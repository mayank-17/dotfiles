{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "mayank-17";
    userEmail = "ms36527@gmail.com";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
