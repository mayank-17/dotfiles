{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      # Make Nix and home-manager installed things available in PATH.
      export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/mayank/.nvm/versions/node/v20.17.0/bin:/home/mayank/.cabal/bin:/home/mayank/.ghcup/bin:/home/mayank/bin:/home/mayank/.local/bin:/home/mayank/.local/bin/lib/9.4.8:/usr/local/bin:/home/mayank/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$PATH
    '';
  };
}
