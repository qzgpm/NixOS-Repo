<div align="center">

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png" width="90px" alt="NixOS Logo"/>

# ❄️ NixOS · DWM Dotfiles

> *A minimal, suckless-driven NixOS configuration — declarative by nature, fast by design.*

[![NixOS](https://img.shields.io/badge/NixOS-25.11-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Flakes](https://img.shields.io/badge/Flakes-enabled-74C7EC?style=for-the-badge&logo=snowflake&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![WM](https://img.shields.io/badge/WM-dwm-1E1E2E?style=for-the-badge&logo=xorg&logoColor=white)](https://dwm.suckless.org)
[![Editor](https://img.shields.io/badge/Editor-Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io)
[![License](https://img.shields.io/badge/License-MIT-CBA6F7?style=for-the-badge)](LICENSE)

</div>

---

## 📸 Preview

<div align="center">
<!-- <img src="./assets/screenshot.png" width="85%" alt="Desktop Preview" /> -->
<i>[ screenshot goes here ]</i>
</div>

---

## 🖥️ System Details

| Component          | Tool                                                          |
|--------------------|---------------------------------------------------------------|
| **OS**             | NixOS 25.11                                                   |
| **Window Manager** | [dwm](https://dwm.suckless.org) (heavily patched)            |
| **Status Bar**     | [dwmblocks](https://github.com/torrinfail/dwmblocks) (custom scripts) |
| **Terminal**       | [st](https://st.suckless.org) (patched)                      |
| **Editor**         | [Neovim](https://neovim.io) via nixvim                       |
| **Shell**          | Zsh (vi-mode, autosuggestions, fzf integration)              |
| **Browser**        | [Librewolf](https://librewolf.net)                           |
| **File Manager**   | [lf](https://github.com/gokcehan/lf) (via `lfub` wrapper)   |
| **Image Viewer**   | [nsxiv](https://github.com/nsxiv/nsxiv)                      |
| **PDF Viewer**     | [zathura](https://pwmt.org/projects/zathura)                 |
| **System Monitor** | [btop](https://github.com/aristocratos/btop)                 |
| **Torrent**        | [qBittorrent](https://qbittorrent.org)                       |
| **Notifications**  | [dunst](https://dunst-project.org)                           |
| **Display Server** | X11                                                           |
| **Screen Locker**  | [slock](https://tools.suckless.org/slock)                    |

---

## 📁 Repository Structure

```
.
├── 📂 .config/                   # Application configs
│   ├── btop/                     # System monitor + themes
│   ├── lf/                       # Terminal file manager
│   ├── qBittorrent/              # Torrent client + RSS feeds
│   └── zathura/                  # PDF & document viewer
│
├── 📂 .dotfiles/                 # NixOS system configuration
│   ├── flake.nix                 # Flake entry point
│   ├── flake.lock                # Pinned input revisions
│   ├── hosts/
│   │   └── laptop/               # Laptop host definition
│   │       ├── default.nix
│   │       ├── hardware-configuration.nix
│   │       └── home/             # Home Manager entry
│   ├── modules/
│   │   ├── home/                 # Home Manager modules
│   │   │   ├── autostart.nix    # Systemd user services (dwmblocks, xrdb, setbg)
│   │   │   ├── dunst.nix        # Notification daemon
│   │   │   ├── fastfetch.nix    # System info display
│   │   │   ├── fonts.nix        # Font configuration
│   │   │   ├── git.nix          # Git settings
│   │   │   ├── mpd.nix          # Music player daemon
│   │   │   ├── mpv.nix          # MPV video player
│   │   │   ├── nsxiv.nix        # Image viewer
│   │   │   ├── nvim.nix         # Neovim config (nixvim)
│   │   │   ├── packages.nix     # User packages
│   │   │   ├── scripts.nix      # Custom script installations
│   │   │   └── zsh.nix          # Zsh shell configuration
│   │   └── system/              # NixOS system modules
│   │       ├── audio.nix         # PipeWire / audio
│   │       ├── boot.nix          # Bootloader
│   │       ├── databases.nix     # Database services
│   │       ├── desktop.nix       # X11 / display manager
│   │       ├── firewall.nix      # Firewall rules
│   │       ├── fonts.nix         # System fonts
│   │       ├── networking.nix    # Network config
│   │       ├── nix.nix           # Nix daemon settings
│   │       ├── packages.nix      # System packages
│   │       ├── picom.nix         # Compositor
│   │       ├── power.nix         # Power management
│   │       ├── security.nix      # Security settings (doas)
│   │       └── users.nix         # User accounts
│   └── overlays/                 # Patched suckless tools (built via Nix)
│       ├── dmenu/
│       ├── dwm/                  # dwm + patches
│       │   └── patch/
│       ├── dwmblocks/
│       └── st/                   # st + patches
│           └── patch/
│
├── 📂 .local/
│   └── bin/
│       ├── bingwall              # Bing wallpaper fetcher
│       ├── displayselect         # Multi-monitor display selector
│       ├── lfub                  # lf with ueberzugpp image previews
│       ├── rotdir                # Directory rotation helper
│       ├── sd                    # Quick directory switcher
│       ├── setbg                 # Wallpaper setter (xwallpaper)
│       ├── shortcuts             # Auto-generate shell shortcuts
│       ├── sysact                # System action menu (shutdown/reboot/lock)
│       ├── toggle_touchpad       # Toggle touchpad on/off
│       └── statusbar/            # Shell scripts powering dwmblocks
│
└── .Xresources                   # X11 theming (colors, fonts, DPI)
```

---

## ✨ Highlights

- 🧱 **Suckless stack** — dwm, st, dmenu, dwmblocks built and patched via Nix overlays
- ❄️ **Flake-based** — targets NixOS 25.11, fully reproducible with pinned inputs
- 🏠 **Home Manager** — user environment declared alongside system config
- 📦 **Modular layout** — clean separation between system and home modules
- ⚡ **Custom statusbar** — 26 lightweight shell scripts feeding into dwmblocks
- 📝 **Neovim via nixvim** — fully declarative Neovim config with Nix
- 🔒 **doas instead of sudo** — privilege escalation via `doas`
- 🎵 **MPD + mpc** — music playback with statusbar integration
- 🖼️ **Wallpaper pipeline** — `setbg` auto-restores wallpaper via systemd user service

---

## 🚀 Installation

> **⚠️ Warning:** These are personal dotfiles — review configs before applying, especially the hardware configuration.

### 1. Clone the repo

```bash
git clone https://github.com/qzgpm/NixOS-Repo.git ~/NixOS-Repo
cd ~/NixOS-Repo
```

### 2. Link dotfiles to expected location

```bash
ln -sf ~/NixOS-Repo/.dotfiles ~/.dotfiles
```

### 3. Point to your hardware

```bash
nixos-generate-config --show-hardware-config > .dotfiles/hosts/laptop/hardware-configuration.nix
```

### 4. Apply system config

```bash
sudo nixos-rebuild switch --flake .dotfiles#laptop
```

### 5. Apply Home Manager

Home Manager is integrated into the NixOS configuration and applies automatically with the above command.

---

## 🔧 Useful Commands

```bash
# Rebuild and switch (using nh alias)
nr                                      # alias for: nh os switch

# Rebuild and update all flake inputs
nu                                      # alias for: nh os switch --update

# Clean up old generations
nc                                      # alias for: nh clean all

# Raw nixos-rebuild equivalents
sudo nixos-rebuild switch --flake ~/.dotfiles#laptop
sudo nixos-rebuild test --flake ~/.dotfiles#laptop   # dry-run

# Update all flake inputs manually
nix flake update

# Check flake for errors
nix flake check
```

---

## 🩹 Patches

Suckless tools are patched and built through Nix overlays in `.dotfiles/overlays/`:

### dwm

| Patch               | Description                                      |
|---------------------|--------------------------------------------------|
| `vanitygaps`        | Inner/outer gaps between windows                 |
| `swallow`           | Terminal window swallowing for GUI apps          |
| `scratchpad`        | Toggleable floating scratchpad window            |
| `statuscmd`         | Clickable statusbar blocks (dwmblocks IPC)       |
| `stacker`           | Move windows up/down the stack                   |
| `shiftview`         | Cycle through non-empty tags                     |
| `shifttag`          | Move window to adjacent tag                      |
| `xresources`        | Read colors and settings from `.Xresources`      |
| `alwaysontop`       | Keep selected window always on top               |
| `aspectresize`      | Resize windows while maintaining aspect ratio    |
| `banish`            | Banish cursor to corner of screen                |
| `restartsig`        | Restart dwm in place without killing X           |
| `seamless_restart`  | Restore window layout after restart              |
| `sticky`            | Sticky windows visible on all tags               |
| `togglefullscreen`  | True fullscreen toggle                           |
| `warp`              | Warp cursor to focused window                    |
| `attachx`           | Control where new windows attach in stack        |

### st

| Patch                   | Description                                    |
|-------------------------|------------------------------------------------|
| `alpha`                 | Background transparency                        |
| `boxdraw`               | Proper box-drawing character rendering         |
| `copyurl`               | Copy URLs with keyboard shortcut               |
| `reflow`                | Reflow text on terminal resize                 |
| `keyboardselect`        | Keyboard-driven text selection                 |
| `newterm`               | Open new terminal in same directory            |
| `openurlonclick`        | Open URLs by clicking                          |
| `osc7`                  | Report current working directory to shell      |
| `osc133`                | Shell integration / prompt marking             |
| `xresources`            | Theme colors from `.Xresources`                |

### dmenu

Stock dmenu — no extra patches applied.

---

## 📜 Statusbar Scripts

26 custom shell scripts in `.local/bin/statusbar/` — piped into **dwmblocks**:

| Script           | Output                              |
|------------------|-------------------------------------|
| `sb-battery`     | Battery percentage & charge status  |
| `sb-brightness`  | Screen brightness level             |
| `sb-clock`       | Date and time                       |
| `sb-cpu`         | CPU usage percentage                |
| `sb-cpubars`     | CPU usage as mini bar graph         |
| `sb-disk`        | Disk usage                          |
| `sb-doppler`     | Music playback (doppler integration)|
| `sb-forecast`    | Weather forecast                    |
| `sb-help-icon`   | Keybinding help indicator           |
| `sb-internet`    | Network connection status           |
| `sb-iplocate`    | External IP / geolocation           |
| `sb-kbselect`    | Keyboard layout indicator           |
| `sb-mailbox`     | Unread mail count                   |
| `sb-memory`      | RAM usage                           |
| `sb-moonphase`   | Current moon phase                  |
| `sb-mpdup`       | MPD update trigger                  |
| `sb-music`       | Currently playing track (MPD)       |
| `sb-nettraf`     | Network traffic (up/down)           |
| `sb-news`        | RSS news headlines                  |
| `sb-pacpackages` | Pending package updates             |
| `sb-popupgrade`  | Popup upgrade notification          |
| `sb-price`       | Cryptocurrency / stock price        |
| `sb-tasks`       | Task count                          |
| `sb-ticker`      | Stock ticker                        |
| `sb-torrent`     | Active torrent status               |
| `sb-volume`      | Audio volume level                  |

---

## 🔑 Shell Aliases & Functions (Zsh)

Notable aliases set in `modules/home/zsh.nix`:

| Alias     | Command                              |
|-----------|--------------------------------------|
| `vim`     | `nvim`                               |
| `sudo`    | `doas`                               |
| `ls`      | `eza` with icons & colors            |
| `cat`     | `bat`                                |
| `grep`    | `ripgrep`                            |
| `du`      | `dust`                               |
| `lf`      | `lfub` (lf + image previews)         |
| `nr`      | `nh os switch` (rebuild)             |
| `nu`      | `nh os switch --update`              |
| `nc`      | `nh clean all`                       |
| `magit`   | `nvim -c MagitOnly`                  |
| `movie`   | fzf-pick a film and open in mpv      |

Helper functions: `se` (fzf-edit a script), `gadd`, `gcommit`, `gpush`, `gpull`.

---

## 🙏 Acknowledgements

- [suckless.org](https://suckless.org) — dwm, st, dmenu
- [nix-community/nixvim](https://github.com/nix-community/nixvim) — declarative Neovim
- [nix-community/home-manager](https://github.com/nix-community/home-manager) — home environment management
- [NixOS Discourse](https://discourse.nixos.org) — community & support

---

<div align="center">

*Built with ❄️ on NixOS · Suckless philosophy, Nix reproducibility*

</div>
