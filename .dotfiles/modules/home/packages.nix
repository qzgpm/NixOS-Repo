{pkgs, ...}: {
  home.packages = with pkgs; [
    # ────────────────────────────────
    # 🧠 Core System & Shell Tools
    # ────────────────────────────────
    wget
    bc
    file
    fd
    fzf
    eza
    bat
    dust
    tealdeer
    ripgrep
    tree

    # ────────────────────────────────
    # 🏗️ Suckless Ecosystem
    # ────────────────────────────────
    st # terminal
    dmenu # launcher
    dwmblocks # status bar
    slock # screen locker

    # ────────────────────────────────
    # 🪟 X11 Environment Tools
    # ────────────────────────────────
    xwallpaper
    xrandr
    xsetroot
    xdotool
    brightnessctl

    # ────────────────────────────────
    # 🖼️ Visuals & Appearance
    # ────────────────────────────────
    pywal # colorscheme generator
    feh # wallpaper setter
    nsxiv # minimalist image viewer
    scrot # screenshots
    xclip # clipboard
    libnotify # notify-send cli

    # ────────────────────────────────
    # 📂 File Management (lf setup)
    # ────────────────────────────────
    lf
    ueberzugpp # image previews
    poppler # PDF previews
    mediainfo # media metadata
    gnome-epub-thumbnailer # epub thumbnails

    # ────────────────────────────────
    # 📄 Documents & Spreadsheets
    # ────────────────────────────────
    zathura # PDF/document viewer
    sc-im # terminal spreadsheet

    # ────────────────────────────────
    # 🎵 Multimedia & Audio
    # ────────────────────────────────
    mpc
    wireplumber # for wpctl
    pulsemixer
    calcurse
    procps # for pkill
    acpilight # for xbacklight

    # ────────────────────────────────
    # 🌐 Browsing & Communication
    # ────────────────────────────────
    librewolf
    tor-browser
    thunderbird

    # ────────────────────────────────
    # 🧭 Networking & Torrents
    # ────────────────────────────────
    qbittorrent
    nicotine-plus
    localsend

    # ────────────────────────────────
    # 📊 System Info & Monitoring
    # ────────────────────────────────
    btop

    # ────────────────────────────────
    # 🎮 Misc / Legacy Tools
    # ────────────────────────────────
    gcc
    python3
    nodejs
    steam-run
  ];
}
