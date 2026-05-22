{config, ...}: {
  imports = [
    ../../../modules/home
  ];

  home.username = "dlvn";
  home.homeDirectory = "/home/dlvn";
  home.stateVersion = "25.11";

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    pictures = "${config.home.homeDirectory}/Pictures";
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
  };

  programs.home-manager.enable = true;
}
