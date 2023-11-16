{
  description = "My Nix-based NeoVim config";

  nixConfig = {
    allow-import-from-derivation = "true";

    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    pre-commit-hooks,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        self',
        system,
        pkgs,
        lib,
        ...
      }: let
        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit pkgs;
          module = ./config;
        };
      in {
        _module.args.pkgs = import nixpkgs {inherit system;};

        checks = {
          default = pkgs.nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "Test nixvim configuration";
          };
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              statix.enable = true;
              alejandra.enable = true;
            };
          };
        };

        packages.default = nvim;

        devShells.default = pkgs.mkShell {
          inherit (self'.checks.pre-commit-check) shellHook;
        };
      };
    };
}
