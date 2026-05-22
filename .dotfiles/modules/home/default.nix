{...}: {
  imports = [
    ./autostart.nix
    ./dunst.nix
    ./fastfetch.nix
    ./fonts.nix
    ./mpv.nix
    ./nsxiv.nix
    ./nvim.nix
    ./mpd.nix
    ./packages.nix
    ./scripts.nix
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

    # XDG base dirs
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";

    # Other
    XDG_MEDIA_DIR = "$HOME/Media";
    NH_FLAKE = "$HOME/.dotfiles";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
