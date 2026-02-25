{
  description = "qzgpm's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.laptop =
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs self; };

        modules = [
          ./nix/hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.dlvn =
              import ./nix/hosts/laptop/home.nix;
          }
        ];
      };
  };
}
