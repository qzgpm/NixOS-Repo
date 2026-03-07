{...}: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    sandbox = true;
    allowed-users = ["@wheel"];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
    persistent = true;
  };

  nixpkgs.config.allowUnfree = true;
}
