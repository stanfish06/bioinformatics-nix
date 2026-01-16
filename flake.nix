{
  description = "bioinformatics";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        systems = [ "x86_64-linux" ];
        imports = [
          ./modules/dataFetch.nix
          ./modules/preprocess.nix
          ./modules/alignment.nix
          ./modules/epigenomics.nix
          ./modules/analysis.nix
        ];
      }
    );
}
