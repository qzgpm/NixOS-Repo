{overlays, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./preservation.nix
    ./impermanence.nix
    ../../modules/system
  ];

  nixpkgs.overlays = overlays;

  system.stateVersion = "25.11";
}
