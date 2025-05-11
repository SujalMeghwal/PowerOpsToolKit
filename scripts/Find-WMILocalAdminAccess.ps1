function Find-WMILocalAdminAccess {
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [string] $ComputerName,

        [Parameter(Position=1)]
        [string] $ComputerFile,

        [switch] $StopOnSuccess
    )

    $ErrorActionPreference = "SilentlyContinue"
    $Results = @()

    function Test-HostAvailability {
        param (
            [string] $Name
        )
        try {
            return Test-Connection -ComputerName $Name -Count 1 -Quiet -ErrorAction Stop
        } catch {
            return $false
        }
    }

    if ($ComputerFile) {
        if (-Not (Test-Path $ComputerFile)) {
            Write-Error "Computer list file not found: $ComputerFile"
            return
        }

        try {
            $Computers = Get-Content -Path $ComputerFile -ErrorAction Stop
        } catch {
            Write-Error "Failed to read file: $_"
            return
        }
    }
    elseif ($ComputerName) {
        if ([string]::IsNullOrWhiteSpace($ComputerName)) {
            Write-Error "Provided ComputerName is null or empty."
            return
        }
        $Computers = @($ComputerName)
    }
    else {
        Write-Verbose "Enumerating computers from Active Directory..."
        try {
            $Computers = ([ADSISearcher]"(objectClass=computer)").FindAll() | ForEach-Object {
                $_.Properties["dnshostname"] | Select-Object -First 1
            }
        } catch {
            Write-Error "Failed to enumerate domain computers: $_"
            return
        }
    }

    foreach ($Computer in $Computers) {
        if ([string]::IsNullOrWhiteSpace($Computer)) { continue }

        Write-Verbose "Checking availability of $Computer..."
        if (-not (Test-HostAvailability -Name $Computer)) {
            Write-Warning "$Computer is unreachable (ping failed)"
            $Results += [PSCustomObject]@{ Computer = $Computer; Status = "Unreachable" }
            continue
        }

        Write-Verbose "Attempting WMI access on $Computer..."
        try {
            $null = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computer -ErrorAction Stop
            Write-Host "Local admin access confirmed on: $Computer" -ForegroundColor Green
            $Results += [PSCustomObject]@{ Computer = $Computer; Status = "Success" }

            if ($StopOnSuccess) { break }
        } catch {
            if ($_.Exception.Message -match "Access is denied") {
                Write-Host "Access denied on: $Computer" -ForegroundColor Yellow
                $Results += [PSCustomObject]@{ Computer = $Computer; Status = "Access Denied" }
            } elseif ($_.Exception.Message -match "RPC server is unavailable") {
                Write-Warning "WMI RPC issue on $Computer"
                $Results += [PSCustomObject]@{ Computer = $Computer; Status = "WMI RPC Failure" }
            } else {
                Write-Warning ("Unexpected error on {0}: {1}" -f $Computer, $_.Exception.Message)
                $Results += [PSCustomObject]@{ Computer = $Computer; Status = "Other Error"; Message = $_.Exception.Message }
            }
        }
    }

    Write-Host "`nSummary of Results:" -ForegroundColor Cyan
    $Results | Format-Table -AutoSize
}
