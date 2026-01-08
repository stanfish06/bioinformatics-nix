{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      devShells.preprocess = pkgs.mkShell {
        packages = with pkgs; [
          fastp
          fastqc
          seqtk
          python3
          perl
          parallel
        ];
        shellHook = ''
          rm -rf .venv-preprocess
          python -m venv .venv-preprocess
          source .venv-preprocess/bin/activate
          pip install cutadapt
          source .venv-preprocess/bin/activate
        '';
      };
    };
}
