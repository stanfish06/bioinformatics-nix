{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      rpkgs = with pkgs.rPackages; [
        ggplot2
        tidyverse
        ChIPseeker
        ComplexHeatmap
      ];
    in
    {
      devShells.analysis = pkgs.mkShell {
        packages = with pkgs; [
          (rstudioWrapper.override { packages = rpkgs; })
          python3
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
