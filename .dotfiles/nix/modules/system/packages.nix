{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # ────────────────────────────────
    # 🧰 Development Tools
    # ────────────────────────────────
    gcc
    gnumake
    pkg-config

    # ────────────────────────────────
    # 🧠 System Utilities
    # ────────────────────────────────
    procps       # system info utilities (ps, top, etc.)
    file         # inspect file types
    fontconfig   # font management

    # ────────────────────────────────
    # 📱 Android / ADB Tools
    # ────────────────────────────────
    android-tools

    # ────────────────────────────────
    # 📦 Archiving & Compression
    # ────────────────────────────────
    zip
    unzip
    p7zip
    unar
  ];
}
