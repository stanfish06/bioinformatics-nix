{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.dataFetch = pkgs.mkShell {
        packages = [
          pkgs.uv
          pkgs.python313
          pkgs.sratoolkit
        ];

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
        ];

        # looper and geofetch is stupid as hell, you need uvx to run them
        shellHook = ''
          uv tool install geofetch --quiet 2>/dev/null || true
          uv tool install looper --quiet 2>/dev/null || true
          echo "Data fetch environment loaded"
          echo "  - geofetch $(geofetch --version 2>&1 | head -1 || echo 'available')"
          echo "  - looper $(looper --version 2>&1 || echo 'available')"
          echo "  - sra-tools: prefetch, fasterq-dump, fastq-dump"
        '';
      };
    };
}
