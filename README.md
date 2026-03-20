# ETHZ VPN Indicator 🚀

A lightweight, secure GTK system tray indicator for ETHZ students and staff. This tool simplifies connecting to the ETH VPN using OpenConnect with native support for TOTP (2FA) and secure credential storage via the system keyring.

## ✨ Features

- Secure Storage: Sensitive credentials (password & TOTP secret) are stored in the System Keyring (GNOME Keyring/Seahorse) rather than plain text files.
- One-Click Connect: Toggle your VPN connection directly from the system tray.
- Desktop Integrated: Native DBus notifications for connection status and error handling.
- Auto-Start: Automatically launches and sits in your tray when you log in.

---

## 📦 Installation

### 1. Download & Install

Go to the Releases page and download the latest .deb package.

sudo apt update
sudo apt install ./ethz-vpn\_\*.deb

### 2. First-Time Setup

After installation, you can find ETHZ VPN in your application menu, or launch it via terminal:

ethz-vpn

1. Click the disconnected VPN icon (gray shield/network icon) in your system tray.
2. Select ⚙️ Run Setup...
3. Enter your ETH Username, Group (e.g., student-net), Password, and your Base32 OTP secret.
   OTP Secret is the string you get when you set up your TOTP app([See this video from ETHZ IT Services](https://www.youtube.com/watch?v=8OzkOPo4Oq8)).
4. Click OK to save.
5. Select Connect VPN from the menu.

---

## 🛠 Troubleshooting

### Sudo Permissions

The installer creates a specific policy in /etc/sudoers.d/ethz-vpn. If the app asks for a sudo password in the terminal or fails to connect, ensure your user is in the sudo group:

groups ${USER} | grep sudo

### Missing Tray Icon

On some GNOME versions (like Ubuntu 22.04+), you may need the AppIndicator and KStatusNotifierItem Support extension enabled for the icon to be visible.

---

## 🧹 Uninstallation

To remove the application and the security policy:

sudo apt remove ethz-vpn

To also wipe your saved local metadata and request a purge of configuration:

sudo apt purge ethz-vpn

---

## 🔒 Security Model

- Keyring Integration: Uses python3-keyring to store the ETH password and TOTP token in the OS-level secure vault (encrypted by your login).
- No Persistent Root: The app runs as a standard user; only the specific VPN tunnel command is elevated.

---

_Disclaimer: This is an unofficial tool and is not maintained by ETH Zurich IT Services. The central Informatikdienste recommend to use the Cisco Secure Client (formerly known as Cisco AnyConnect)._
