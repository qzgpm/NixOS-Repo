{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = false; # Using fast-syntax-highlighting instead

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.cache/zsh/history";
      ignoreAllDups = true;
      share = true;
    };

    shellAliases = {
      # Editor
      vim = "nvim";
      v = "nvim";
      
      # Sudo (doas)
      sudo = "doas";
      s = "doas";
      
      # Common
      ls = "eza -h --icons --group-directories-first --color=always";
      la = "eza -ah --icons --group-directories-first --color=always";
      ll = "eza -lh --icons --group-directories-first --color=always";
      grep = "grep -i --color=auto";
      cat = "bat -pp";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      
      # Nix
      nr = "nh os switch";
      nu = "nh os switch --update";
      nc = "nh clean all";
      
      # Misc
      lf = "lfub";
      magit = "nvim -c MagitOnly";
      xclip = "xclip -selection clipboard";
      
      # Config shortcuts
      cfz = "$EDITOR /home/dlvn/Documents/NixOS-Repo/.dotfiles/modules/home/zsh.nix";
      cfn = "$EDITOR /home/dlvn/Documents/NixOS-Repo/.dotfiles/modules/system/default.nix";
    };

    initExtra = ''
      # Prompt
      PS1="%B%F{8}[%F{7}%n%F{8}@%F{7}%M %F{7}%~%F{8}]%f$%b "

      # Vi mode
      bindkey -v
      export KEYTIMEOUT=1

      # Cursor shape for vi modes
      zle-keymap-select() {
        case $KEYMAP in
          vicmd) echo -ne '\e[1 q';;
          viins|main) echo -ne '\e[5 q';;
        esac
      }
      zle -N zle-keymap-select
      zle-line-init() { zle -K viins; echo -ne "\e[5 q"; }
      zle -N zle-line-init
      
      # FZF integration
      source <(fzf --zsh)
    '';

    completionInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    '';
  };
}
