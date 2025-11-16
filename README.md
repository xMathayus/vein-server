# VEIN Server

![VEIN Dashboard Logo](dash/static/logo.png)

This is a guided Windows setup for quickly installing a VEIN dedicated server, including a dashboard and automated backup functions. 

This solution consists of a Windows batch script that automates the process described at https://ramjet.notion.site/dedicated-servers (as of November 17, 2025), a backup script that can manually or daily backup the servers save data, and a Python program that serves a dashboard for ease of use starting/stopping and logging the server.

## Installation

To install the VEIN Server, just clone the repo, run install script executable (setup-vein-server.bat), and then run it:

Edit The Start-VeinServer.bat and adjust the launch parameters:
- QueryPort=27015 
- Port=7777

To start the VEIN dashboard, run: ( Run-Dash.bat )
- This opens the web dashboard for managing the server and viewing logs.

## Screenshots

### Dashboard
![App Screenshot](https://i.imgur.com/1pDEitr.png)


## Requirements

- **Windows 10 or 11 (64-bit)**
- **Internet connection** (for SteamCMD and VEIN server downloads)
- **Python 3.10+** with `py` and `pip` available on `PATH`
- **PowerShell** with permission to run local scripts

If PowerShell blocks scripts, run this **once** in an elevated PowerShell:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## Credits / Original Project

All original credit for the concept, Linux implementation, and initial dashboard goes to:

- **warmbo** – original project:  
  ➜ https://github.com/warmbo/vein-server

This Windows fork simply re-implements the same idea using **PowerShell**, **batch files**, and **Flask** instead of `bash`, `systemd`, and `journalctl`.
