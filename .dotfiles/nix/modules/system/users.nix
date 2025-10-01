{ config, pkgs, ... }:

{
  users.users.dlvn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}
