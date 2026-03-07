{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  nixpkgs.overlays = [
    (import ../../overlays)
  ];

  system.stateVersion = "25.05";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
    persistent = true;
  };
}
