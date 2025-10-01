{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable=true;
  };

# services.displayManager.ly = {
#   enable = true;
#   settings.default_session = "x";
# };

  services.dbus.enable = true;
}
