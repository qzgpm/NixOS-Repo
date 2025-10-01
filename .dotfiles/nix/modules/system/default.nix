{
  boot = import ./boot.nix;
  networking = import ./networking.nix;
  timezone = import ./timezone.nix;
  fonts = import ./fonts.nix;
  desktop = import ./desktop.nix;
  audio = import ./audio.nix;
  extras = import ./extras.nix;
  databases = import ./databases.nix;
  users = import ./users.nix;
  programs = import ./programs.nix;
  packages = import ./packages.nix;
}
