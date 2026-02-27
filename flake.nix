{
  description = "paro-neovim — Portable Neovim configuration by cooparo";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self, nixpkgs, nix-colors }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.callPackage ./package.nix { inherit nix-colors; };

          # Allow theme override: nix run .#everforest
          nord = pkgs.callPackage ./package.nix {
            inherit nix-colors;
            theme = "nord";
          };
          everforest = pkgs.callPackage ./package.nix {
            inherit nix-colors;
            theme = "everforest";
          };
          catppuccin = pkgs.callPackage ./package.nix {
            inherit nix-colors;
            theme = "catppuccin";
          };
          gruvbox = pkgs.callPackage ./package.nix {
            inherit nix-colors;
            theme = "gruvbox-dark-medium";
          };
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });
    };
}
