{ config, pkgs, ... }:

{
  home.username = "dlvn";
  home.homeDirectory = "/home/dlvn";

  imports = [
    ../../modules/home/common.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
