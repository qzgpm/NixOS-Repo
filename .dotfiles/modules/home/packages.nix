{pkgs, ...}: {
  home.packages = with pkgs; [
    # ────────────────────────────────
    # 🧠 Core System & Shell Tools
    # ────────────────────────────────
    neovim
    git
    wget
    bc
    file
    fd
    fzf
    eza
    bat
    dust
    tealdeer
    zsh-fast-syntax-highlighting
    unclutter

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
    feh # wallpaper + image viewer
    nsxiv # minimalist image viewer
    scrot # screenshots
    xclip # clipboard
    dunst # notifications
    libnotify

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

    # ────────────────────────────────
    # 🌐 Browsing & Communication
    # ────────────────────────────────
    librewolf
    #qutebrowser
    tor-browser
    thunderbird

    # ────────────────────────────────
    # 🧭 Networking & Torrents
    # ────────────────────────────────
    qbittorrent
    nicotine-plus

    # ────────────────────────────────
    # 📊 System Info & Monitoring
    # ────────────────────────────────
    btop
    fastfetch

    # ────────────────────────────────
    # 🎮 Misc / Legacy Tools
    # ────────────────────────────────
    python3
    pyright
    ruff
    clang-tools
    nixd
    alejandra
    steam-run
  ];
}
