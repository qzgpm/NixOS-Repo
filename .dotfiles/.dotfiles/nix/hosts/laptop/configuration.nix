{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ] ++ builtins.attrValues (import ../../modules/system);

  nixpkgs.overlays = import ../../overlays;

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
