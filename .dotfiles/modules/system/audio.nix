{...}: {
  services.pipewire = {
    enable = true;

    audio.enable = true; # modern option
    pulse.enable = true; # PulseAudio replacement
    alsa.enable = true; # ALSA support
    alsa.support32Bit = true; # needed for some apps (Steam etc.)
  };

  services.pulseaudio.enable = false;
}
