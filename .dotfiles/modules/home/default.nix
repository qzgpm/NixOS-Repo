{...}: {
  imports = [
    ./dunst.nix
    ./fastfetch.nix
    ./fonts.nix
    ./mpv.nix
    ./nsxiv.nix
    ./mpd.nix
    ./packages.nix
    ./zsh.nix
    ./git.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
    TERMINAL_PROG = "st";
    BROWSER = "librewolf";
    XINITRC = "$HOME/.config/x11/xinitrc";
    FZF_DEFAULT_COMMAND = "fd --hidden --color=never --type f --exclude .git";
    FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
