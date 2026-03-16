{...}: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    sandbox = true;
    allowed-users = ["@wheel"];
    warn-dirty = false;
    use-xdg-base-directories = true;
    flake-registry = ""; # Disable global registry for faster lookups
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    persistent = true;
  };

  nixpkgs.config.allowUnfree = true;
}
