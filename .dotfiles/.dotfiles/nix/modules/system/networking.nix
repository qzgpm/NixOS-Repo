{ config, pkgs, ... }:

{
  networking.hostName = "me";
  networking.networkmanager.enable = true;
}
