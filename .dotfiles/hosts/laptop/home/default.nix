{...}: {
  imports = [
    ../../../modules/home
  ];

  home.username = "dlvn";
  home.homeDirectory = "/home/dlvn";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
