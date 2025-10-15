{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;
}
