{...}: {
  programs.git = {
    enable = true;
    userName = "Delvin";
    userEmail = "dlvn3jai@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
