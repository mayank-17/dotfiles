{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./catppuccin-starship.toml;
  };
}
