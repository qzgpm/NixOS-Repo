{...}: {
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

      # Sudo (doas)
      sudo = "doas";

      # Common (Verbosity & Colors)
      ls = "eza -h --icons --group-directories-first --color=always";
      tree = "eza --tree";
      grep = "rg --smart-case";
      cat = "bat -pp";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      ln = "ln -i";
      xargs = "xargs -r";
      bc = "bc -ql";
      ka = "killall";
      du = "dust -d 2 --reverse";
      df = "df -h | bat -p -l conf";
      python = "python -q";
      less = "bat --paging=always --plain";
      rsync = "rsync -avhP";
      diff = "diff --color=auto";
      ip = "ip -color=auto";
      lsblk = "lsblk|bat -p -l conf";

      # Nix
      nr = "nh os switch ";
      nu = "nh os switch --update ";
      nc = "nh clean all ";

      # Misc
      yz = "yazi";
      xclip = "xclip -selection clipboard";
      startx = "[ -n \"$XINITRC\" ] && [ -f \"$XINITRC\" ] && startx \"$XINITRC\"";
      movie = "fd -tf -E \"*.srt\" -p Films | fzf | xargs -r -I {} mpv {}";
    };

    initContent = ''
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

      # ==============================
      # Doas shortcuts for privileged commands
      # ==============================
      for cmd in mount umount sv updatedb su shutdown poweroff reboot; do
        alias "$cmd"="doas $cmd"
      done
      unset cmd

      # ==============================
      # Helper functions
      # ==============================
      se() {
        local choice
        choice="$(find ~/.local/bin -mindepth 1 -printf '%P\n' | fzf)"
        [ -f "$HOME/.local/bin/$choice" ] && "$EDITOR" "$HOME/.local/bin/$choice"
      }

      gadd() { git add .; }
      gcommit() { [ $# -eq 0 ] && git commit || git commit -m "$*"; }
      gpush() {
        local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
        [ -n "$branch" ] && git push -u origin "$branch" || echo "Not a git repository"
      }
      gpull() {
        local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
        [ -n "$branch" ] && git pull origin "$branch" || echo "Not a git repository"
      }
    '';

    envExtra = ''
      # Disable prompt spacing artifact
      unsetopt PROMPT_SP 2>/dev/null

      # Failsafe for shortcut dirs
      [ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid -f shortcuts >/dev/null 2>&1

    '';

    completionInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    '';
  };
}
