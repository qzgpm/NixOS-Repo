{...}: {
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    dpi = 96;
    xkb.options = "caps:swapescape";

    # Wire DISPLAY/XAUTHORITY into the systemd user session and activate
    #displayManager.sessionCommands = ''
    #  ${"/run/current-system/sw/bin/dbus-update-activation-environment"} --systemd DISPLAY XAUTHORITY
    #  systemctl --user start --no-block graphical-session.target
    #'';
  };

  # Use XKB settings for the virtual console (TTY)
  console.useXkbConfig = true;

  # Ly display manager
  services.displayManager.ly = {
    enable = true;
    settings.save = true;
  };

  services.udisks2.enable = true;

  # Hide cursor when inactive
  services.unclutter = {
    enable = true;
    threshold = 1;
  };
}
