{ config, pkgs, lib, ... }:

{
  services.mpd = {
    enable = true;

    musicDirectory = "${config.home.homeDirectory}/Media/Music";
    dataDir = "${config.home.homeDirectory}/.local/share/mpd";

    extraConfig = ''
      auto_update "yes"
      restore_paused "yes"

      # UNIX socket only
      bind_to_address "${config.home.homeDirectory}/.config/mpd/socket"

      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }

      audio_output {
        type "fifo"
        name "Visualizer feed"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      mpd_host = "${config.home.homeDirectory}/.config/mpd/socket";
    };
  };
}
