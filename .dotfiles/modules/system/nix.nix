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

  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    persistent = true;
  };

  nix.channel.enable = false;

  nixpkgs.config.allowUnfree = true;
}
