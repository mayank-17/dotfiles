{
  description = "Home Manager configuration of mayank";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, flake-utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # Home Manager setup
      homeConfigurations."mayank" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      # # Dev server apps
      # apps.${system} = {
      #   redis = {
      #     type = "app";
      #     program = toString (pkgs.writeShellScript "start-redis" ''
      #       echo "Starting Redis server..."
      #       exec ${pkgs.redis}/bin/redis-server
      #     '');
      #   };
      # };
    };
}
