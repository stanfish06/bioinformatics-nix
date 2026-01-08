{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      rpkgs = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          ggplot2
          tidyverse
          ChIPseeker
          ComplexHeatmap
        ];
      };
    in
    {
      devShells.analysis = pkgs.mkShell {
        packages = with pkgs; [
          R
          rpkgs
          python3
          rstudio
          (python3.withPackages (
            ps: with ps; [
              numpy
              scipy
              pandas
              seaborn
              matplotlib
              statsmodels
              jupyterlab
            ]
          ))
        ];
      };
    };
}
