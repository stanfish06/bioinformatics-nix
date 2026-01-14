{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      devShells.alignment = pkgs.mkShell {
        packages = with pkgs; [
          bowtie2
          samtools
          picard-tools
          bedtools
          parallel
        ];
        shellHook = ''
          echo "Alignment environment loaded"
          echo "Tools: bowtie2, samtools, picard, bedtools"
        '';
      };
    };
}
