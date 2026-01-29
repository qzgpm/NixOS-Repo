{ config, pkgs, ... }:

{
  home.username = "dlvn";
  home.homeDirectory = "/home/dlvn";

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/dunst.nix
    ../../modules/home/fastfetch.nix
    ../../modules/home/fonts.nix
    ../../modules/home/mpv.nix
    ../../modules/home/nsxiv.nix
    ../../modules/home/mpd.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
