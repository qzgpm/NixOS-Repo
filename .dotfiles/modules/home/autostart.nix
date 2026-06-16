{
  pkgs,
  config,
  ...
}: {
  # ──────────────────────────────────────────────────────
  # dwmblocks — status bar
  # ──────────────────────────────────────────────────────
  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "dwmblocks status bar";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.dwmblocks}/bin/dwmblocks";
      Restart = "on-failure";
      RestartSec = "1s";
      Environment = "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # ──────────────────────────────────────────────────────
  # xrdb
  # ──────────────────────────────────────────────────────
  systemd.user.services.xrdb = {
    Unit = {
      Description = "Load Xresources";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.xrdb}/bin/xrdb -merge %h/.Xresources";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # ──────────────────────────────────────────────────────
  # setbg
  # ──────────────────────────────────────────────────────
  systemd.user.services.setbg = {
    Unit = {
      Description = "Restore desktop wallpaper";
      After = ["graphical-session.target" "xrdb.service"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "%h/.local/bin/setbg";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
