{ ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      rpkgs = with pkgs.rPackages; [
        ggplot2
        ggraph
        tidyverse
        ChIPseeker
        ComplexHeatmap
        DESeq2
        Polychrome
        patchwork
        ggpubr
        tximport
      ];

      python = pkgs.python3;

      pythonEnv = python.withPackages (
        ps: with ps; [
          scanpy
          numpy
          scipy
          pandas
          seaborn
          matplotlib
          statsmodels
          networkx
          adjusttext
          jupyterlab
        ]
      );
    in
    {
      devShells.analysis = pkgs.mkShell {
        packages = with pkgs; [
          (rWrapper.override { packages = rpkgs; })
          (rstudioWrapper.override { packages = rpkgs; })
          igv
          pythonEnv
        ];
      };
    };
}
