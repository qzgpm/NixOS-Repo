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
      nr = "nh os switch";
      nu = "nh os switch --update";
      nc = "nh clean all";

      # Misc
      lf = "lfub";
      magit = "nvim -c MagitOnly";
      xclip = "xclip -selection clipboard";
      startx = "[ -n \"$XINITRC\" ] && [ -f \"$XINITRC\" ] && startx \"$XINITRC\"";
      movie = "fd -tf -E \"*.srt\" -p Films | fzf | xargs -r -I {} mpv {}";

      # Config shortcuts
      cfz = "$EDITOR /home/dlvn/Documents/NixOS-Repo/.dotfiles/modules/home/zsh.nix";
      cfn = "$EDITOR /home/dlvn/Documents/NixOS-Repo/.dotfiles/modules/system/default.nix";
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
      # Sudo shortcuts
      # ==============================
      for cmd in mount umount sv updatedb su shutdown poweroff reboot; do
        alias "$cmd"="sudo $cmd"
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
      # Add all directories to ~/.local/bin to $PATH
      export PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':' -)"

      # Disable Prompt
      unsetopt PROMPT_SP 2>/dev/null

      # Default programs
      export EDITOR="nvim"
      export TERMINAL="st"
      export TERMINAL_PROG="st"
      export BROWSER="librewolf"

      # Home cleanup
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_CACHE_HOME="$HOME/.cache"
      export XDG_DOWNLOAD_DIR="$HOME/Downloads"
      export XDG_DOCUMENTS_DIR="$HOME/Documents"
      export XDG_MEDIA_DIR="$HOME/Media"
      export XDG_PICTURES_DIR="$HOME/Pictures"
      export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
      export HISTFILE="$XDG_DATA_HOME/history"

      # FZF
      export FZF_DEFAULT_COMMAND='fd --hidden --color=never --type f --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

      # Failsafe for shortcut
      [ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid -f shortcuts >/dev/null 2>&1

      # Start graphical server in tty if not already started
      [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

      # Switch escape and caps on initial startup
      sudo -n loadkeys "$XDG_DATA_HOME/scripts/ttymaps.kmap" 2>/dev/null
    '';

    completionInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    '';
  };
}
