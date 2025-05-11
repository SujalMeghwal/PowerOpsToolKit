![image](https://github.com/user-attachments/assets/5a9b74b4-8446-4bef-bb36-6931291df583)

# PowerOpsToolKit
![PowerShell](https://img.shields.io/badge/PowerShell-7+-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Offensive PowerShell toolkit for red teams and internal assessments — WMI, recon, lateral movement, and access testing at scale.

## Description
PowerOpsToolKit is my personal collection of modern PowerShell scripts for offensive Windows operations — built out of frustration with outdated, broken, or abandoned tools commonly found in red team blogs and videos. Many of the scripts used in popular tutorials are 5+ years old and simply no longer work in modern Active Directory environments.

This repo started as a way to fix that: I’m actively learning, testing, and rewriting scripts as I go — customizing them for real-world use in AD recon, privilege escalation, access validation, lateral movement, and more. I’ve combined pieces of older public tools with new code to match my current needs, and I plan to expand this toolkit as I grow in my offensive Windows journey.

If you're learning offensive PowerShell or want up-to-date scripts that work on modern Windows networks, PowerOpsToolKit might be a solid place to start or contribute to.

## 📂 Toolkit Structure

### 📁 scripts/
Contains individual PowerShell scripts for various offensive and reconnaissance use cases.

### 📁 docs/
Usage examples, OPSEC notes, and command breakdowns.

### 🛡️ Usage Guidelines
* Intended for authorized testing, red teaming, and educational use only.
* Always ensure proper permission before running scripts in production or external networks.
* Designed for internal assessments, defense simulation, and research.


## 📂 Included Scripts

| Script Name                    | Description                                 |
|-------------------------------|---------------------------------------------|
| `Find-WMILocalAdminAccess.ps1`| Checks if local admin WMI access is available on remote systems. |
| ...                           | More coming soon!                           |

### 📄 License
This project is licensed under the MIT License.

### 🤝 Contributing
Pull requests are welcome! If you have a useful offensive script, OPSEC improvement, or enhancement idea, feel free to fork, tweak, and submit a PR.
Want to help organize docs, examples, or even build a PowerShell module from these? Reach out.

