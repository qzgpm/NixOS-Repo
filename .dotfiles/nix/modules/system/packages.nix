{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    pkg-config
    fontconfig
    android-tools
    procps
    file
    unzip
    p7zip
  ];
}
