{
  description = "qzgpm's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = system;

        modules = [
          ./nix/hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dlvn = import ./nix/hosts/laptop/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };

    apps.${system}.gog-shell = {
      type = "app";
      program = "${pkgs.buildFHSEnv {
        name = "gog-shell";
        targetPkgs = pkgs: with pkgs; [
          bash
          coreutils
          glibc
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr
          alsa-lib
          pulseaudio
          libGL
          mesa
          mesa.drivers
        ];
        runScript = "bash";
      }}/bin/gog-shell";
    };
  };
}
