{...}: {
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;

    displayManager.sessionCommands = ''
      if [ -f $HOME/.config/x11/xinitrc ]; then
        . $HOME/.config/x11/xinitrc
      elif [ -f $HOME/.xinitrc ]; then
        . $HOME/.xinitrc
      fi
    '';
  };

  services.displayManager.ly = {
    enable = true;
    settings.save = true;
  };

  services.dbus.enable = true;
}
