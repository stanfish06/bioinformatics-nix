{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      rpkgs = with pkgs.rPackages; [
        ggplot2
        ggraph
        tidyverse
        ChIPseeker
        ComplexHeatmap
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
          jupyterlab
        ]
      );
    in
    {
      devShells.analysis = pkgs.mkShell {
        packages = with pkgs; [
          R
          (rstudioWrapper.override { packages = rpkgs; })
          igv
          pythonEnv
        ];
      };
    };
}
