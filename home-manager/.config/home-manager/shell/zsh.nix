{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = ''
      save_history() { builtin history -a &>/dev/null }
      load_history() { builtin history -n &>/dev/null }
      export KUBECONFIG=$HOME/.kube/config
      # Make Nix and home-manager installed things available in PATH.
      export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/mayank/.nvm/versions/node/v20.17.0/bin:/home/mayank/.cabal/bin:/home/mayank/.ghcup/bin:/home/mayank/bin:/home/mayank/.local/bin:/home/mayank/.local/bin/lib/9.4.8:/usr/local/bin:/home/mayank/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
      
      mystow() {
        stow --target="$HOME" -Rv "$@" 2>&1 | grep -vE "BUG in find_stowed_path|/nix/store"
      }
      printf '\e[5 q'
    '';
    shellAliases = {
      ls = "ls -lah";
      nix-dotfiles-sync = "(cd $HOME/.config/home-manager && nix run nixpkgs#home-manager -- switch)";
      gco = "git checkout";
      tmux = "tmux -u";
      reload = "exec zsh";
    };

    history = {
      path = "$HOME/.zsh_history";
      size = 100000;
      save = 100000;
      share = true; # share history between sessions
      expireDuplicatesFirst = true;
      extended = true;
    };

    initExtra = ''
      # Save history on exit
      trap 'builtin history -a; builtin history -r' EXIT
    '';
  };
}
