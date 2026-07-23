# ArchR (GreenleafLab/ArchR) — not in nixpkgs; built from the v1.0.3 release.
{
  buildRPackage,
  fetchFromGitHub,
  chromVARmotifs,
  presto,
  BiocGenerics,
  Biostrings,
  chromVAR,
  ComplexHeatmap,
  data_table,
  devtools,
  GenomicRanges,
  ggplot2,
  ggrepel,
  gridExtra,
  gtable,
  gtools,
  harmony,
  magrittr,
  Matrix,
  matrixStats,
  motifmatchr,
  nabor,
  plyr,
  Rcpp,
  RcppArmadillo,
  rhdf5,
  Rsamtools,
  S4Vectors,
  Seurat,
  SeuratObject,
  sparseMatrixStats,
  stringr,
  SummarizedExperiment,
  uwot,
}:
buildRPackage {
  name = "ArchR";
  src = fetchFromGitHub {
    owner = "GreenleafLab";
    repo = "ArchR";
    rev = "v1.0.3";
    hash = "sha256-kpZE4ECwZpEk5QHc+ZhT6rYRG/+efzVkhhn2LpvNrRk=";
  };
  # ArchR's ./configure is a telemetry ping to plausible.io via curl;
  # it does nothing functional and breaks the sandboxed build. Drop it.
  postPatch = "rm -f configure";
  propagatedBuildInputs = [
    BiocGenerics
    Biostrings
    chromVAR
    ComplexHeatmap
    data_table
    devtools
    GenomicRanges
    ggplot2
    ggrepel
    gridExtra
    gtable
    gtools
    harmony
    magrittr
    Matrix
    matrixStats
    motifmatchr
    nabor
    plyr
    Rcpp
    RcppArmadillo
    rhdf5
    Rsamtools
    S4Vectors
    Seurat
    SeuratObject
    sparseMatrixStats
    stringr
    SummarizedExperiment
    uwot
    chromVARmotifs
    presto
  ];
}
