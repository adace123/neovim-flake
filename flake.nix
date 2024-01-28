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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tree-sitter-nu = {
      url = "github:nushell/tree-sitter-nu";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    pre-commit-hooks,
    ...
  } @ inputs: let
    systems = ["x86_64-linux" "x86_64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    forEachPkgs = f: forEachSystem (system: f (import nixpkgs {inherit system;}));
  in {
    packages = forEachPkgs (pkgs: let
      nvim = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        module = ./config;
      };
    in {
      default = nvim;
    });

    checks = forEachPkgs (pkgs: {
      pre-commit-check = inputs.pre-commit-hooks.lib.${pkgs.system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
      };
    });
    devShells = forEachPkgs (pkgs: {default = pkgs.mkShell {inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;};});
  };
}
