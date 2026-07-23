{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../overlays/python.nix)
          (import ../overlays/r.nix)
        ];
      };
    in
    {
      # The overlaid, unfree-enabled package set becomes the shared `pkgs` for
      # every perSystem module (replacing flake-parts' default and the previous
      # ad-hoc `import nixpkgs` in dataFetch.nix), so all shells see the local
      # packages and nixpkgs is instantiated once.
      _module.args.pkgs = pkgs;

      # Each locally-packaged tool is also a standalone build target:
      #   nix build .#pyGenomeTracks
      #   nix build .#archr
      packages = {
        inherit (pkgs.python3.pkgs)
          celluloid
          halp
          pybedtools
          gffutils
          cooler
          hicmatrix
          crossmap
          pyGenomeTracks
          ;
        inherit (pkgs.rPackages)
          presto
          chromVARmotifs
          archr
          ;
      };
    };
}
