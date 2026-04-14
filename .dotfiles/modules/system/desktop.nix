{...}: {
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;

    displayManager.sessionCommands = ''
      [ -f $HOME/.config/x11/xprofile ] && \
        . $HOME/.config/x11/xprofile
    '';
  };

  services.displayManager.ly = {
    enable = true;
    settings.save = true;
  };

  services.dbus.enable = true;
}
