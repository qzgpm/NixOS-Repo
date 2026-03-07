{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  nixpkgs.overlays = [
    (import ../../overlays)
  ];

  system.stateVersion = "25.05";
}
