{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  programs.appimage.enable = true;
}
