{
  description = "Delvin's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      flake = {
        overlays.default = import ./overlays;
        nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {inherit inputs self;};

          modules = [
            ./hosts/laptop

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              home-manager.users.dlvn =
                import ./hosts/laptop/home;
            }
          ];
        };
      };
    };
}
