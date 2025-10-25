{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    # ────────────────────────────────
    # 🧠 Core System & Shell Tools
    # ────────────────────────────────
    neovim
    git
    wget
    bc
    fzf
    eza
    bat
    dust
    tealdeer
    zsh-fast-syntax-highlighting
    unclutter

    # ────────────────────────────────
    # 🏗️ Suckless Ecosystem
    # (lightweight + minimal setup)
    # ────────────────────────────────
    st          # terminal
    dmenu       # launcher
    dwmblocks   # status bar
    slock       # screen locker

    # ────────────────────────────────
    # 🪟 X11 Environment Tools
    # ────────────────────────────────
    xwallpaper
    xorg.xrandr
    xorg.xsetroot
    xdotool
    brightnessctl

    # ────────────────────────────────
    # 🖼️ Visuals & Appearance
    # ────────────────────────────────
    pywal        # colorscheme generator
    feh          # wallpaper + image viewer
    nsxiv        # minimalist image viewer
    scrot        # screenshots
    xclip        # clipboard
    dunst        # notifications
    libnotify

    # ────────────────────────────────
    # 📂 File Management (lf setup)
    # ────────────────────────────────
    lf
    ueberzugpp              # image previews
    poppler                 # PDF previews
    mediainfo               # media metadata
    gnome-epub-thumbnailer  # epub thumbnails

    # ────────────────────────────────
    # 📄 Documents & Spreadsheets
    # ────────────────────────────────
    zathura    # PDF/document viewer
    sc-im      # terminal spreadsheet

    # ────────────────────────────────
    # 🎵 Multimedia & Audio
    # ────────────────────────────────
    mpv
    mpd
    mpc

    # ────────────────────────────────
    # 🌐 Browsing & Communication
    # ────────────────────────────────
    librewolf-bin
    qutebrowser
    tor-browser
    thunderbird

    # ────────────────────────────────
    # 🧭 Networking & Torrents
    # ────────────────────────────────
    qbittorrent

    # ────────────────────────────────
    # 📊 System Info & Monitoring
    # ────────────────────────────────
    btop
    fastfetch

    # ────────────────────────────────
    # 🎮 Misc / Legacy Tools
    # ────────────────────────────────
    dosbox
  ];
}
