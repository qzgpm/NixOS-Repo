{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # ────────────────────────────────
    # 🧠 System Utilities
    # ────────────────────────────────
    procps # system info utilities (ps, top, etc.)
    flac # Music file management
    cryptsetup # Drive Encryption

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
