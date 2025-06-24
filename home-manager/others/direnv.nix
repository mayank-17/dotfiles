{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;  # if you use bash
    enableZshIntegration = true;   # if you use zsh
    nix-direnv.enable = true;      # recommended for Nix users
  };
}
