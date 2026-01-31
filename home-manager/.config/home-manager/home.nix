{ config, pkgs, ... }:

{
  imports = [
    ./shell/bash.nix
    ./others/direnv.nix
    ./others/fzf.nix
    ./others/git.nix
    ./others/starship.nix
    ./others/zoxide.nix
    ./shell/zsh.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mayank";
  home.homeDirectory = "/home/mayank";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    k3d
    nil
    nixpkgs-fmt
    bat
    neofetch
    jq
    nerd-fonts.jetbrains-mono
    jetbrains.idea-community
    openjdk17
    zoxide
    ulauncher
    maven
    kubectl
    kubectx
    nodejs_22
    docker-compose
    taskwarrior3
    lazydocker
    magic-wormhole
    uv
    fzf
    direnv
    lazygit
    rustup
    go
    gemini-cli
    ccache
    bottom
    lld_20
    llvmPackages_20.libcxxClang
    glibc
    glibc.dev
    zellij
    xclip
    # alacritty
    # nixVulkanNvidia
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mayank/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    KUBECONFIG = "$HOME/.kube/config";
  };

  # For PATH, it's even better to use home.sessionPath
  # because it handles appending/prepending automatically.
  home.sessionPath = [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
    "/home/mayank/.nvm/versions/node/v20.17.0/bin"
    "/home/mayank/.cabal/bin"
    "/home/mayank/.ghcup/bin"
    "/home/mayank/bin"
    "/home/mayank/.local/bin"
    "/home/mayank/.local/bin/lib/9.4.8"
    "/home/mayank/.cargo/bin"

    # You might want to remove the standard /usr/local/bin etc. from here
    # and let the default PATH handle them, or explicitly manage them.
    # If they are already in the system PATH, no need to duplicate them here.
  ];

  # nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
