{pkgs, ...}: {
  users.users.dlvn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
    hashedPassword= "$y$j9T$wffwRE9g2A/ucqM5SbXRNX.$0qYa7s.zMHhyiXZ9GW.RIuGACazGg34dniqS.PGX7C2";
  };
}
