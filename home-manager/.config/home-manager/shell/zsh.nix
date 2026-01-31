{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = ''
      # Ensure the file exists before sourcing
      if [ -f "$HOME/.config/home-manager/shell/extra-config.zsh" ]; then
        source "$HOME/.config/home-manager/shell/extra-config.zsh"
      else
        echo "Warning: ~/.config/home-manager/shell/extra-config.zsh not found!" >&2
      fi
    '';
    shellAliases = {
      ls = "ls -lah";
      nix-dotfiles-sync =
        "(cd $HOME/.config/home-manager && nix run nixpkgs#home-manager -- switch)";
      gco = "git checkout";
      tmux = "tmux -u";
      reload = "exec zsh";
      pbcopy= "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
    };

    history = {
      path = "$HOME/.zsh_history";
      size = 100000;
      save = 100000;
      share = true; # share history between sessions
      expireDuplicatesFirst = true;
      extended = true;
    };

    initContent = ''
      # Save history on exit
      # trap 'builtin history -a; builtin history -r' EXIT
    '';
  };
}
