{ ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      pythonEnv = pkgs.python3.withPackages (
        ps: with ps; [
          pyGenomeTracks
          crossmap
          cooler
          hicmatrix
          halp
          pybedtools
          gffutils
        ]
      );

      rEnv = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          BSgenome_Hsapiens_UCSC_hg38
          Matrix
          GenomicRanges
          S4Vectors
          SummarizedExperiment
          SingleCellExperiment
          zellkonverter
          archr
        ];
      };
    in
    {
      devShells.epigenomics = pkgs.mkShell {
        packages = with pkgs; [
          samtools
          macs2
          bedtools
          deeptools
          rEnv
          pythonEnv
        ];

        # ArchR's findMacs2() honours a MACS2_PATH pointing at the macs2 binary.
        shellHook = ''
          export MACS2_PATH=${pkgs.macs2}/bin/macs2
        '';
      };
    };
}
