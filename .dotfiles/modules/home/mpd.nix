{...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Media/Music";

    extraConfig = ''
      auto_update "yes"
      restore_paused "yes"

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

  programs.ncmpcpp.enable = true;
}
