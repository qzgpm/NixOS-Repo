{overlays, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  nixpkgs.overlays = overlays;

  system.stateVersion = "25.11";
}
