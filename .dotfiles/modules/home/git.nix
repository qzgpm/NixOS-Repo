{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Delvin";
        email = "dlvn3jai@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
