{ config, pkgs, ... }:

{
  services.picom.enable = true;
  services.udisks2.enable = true;
  services.mpd.enable = true;
}
