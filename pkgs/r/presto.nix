# presto (immunogenomics/presto) — GitHub only, ArchR Import.
{
  buildRPackage,
  fetchFromGitHub,
  Rcpp,
  RcppArmadillo,
  data_table,
  dplyr,
  tidyr,
  purrr,
  tibble,
  Matrix,
  rlang,
}:
buildRPackage {
  name = "presto";
  src = fetchFromGitHub {
    owner = "immunogenomics";
    repo = "presto";
    rev = "a24772a135c7895a8183b007376050556c60a05b";
    hash = "sha256-gVgqEvSg9xMTvw0brYy6iyxJF2y2LT65EWRmGYYEQxw=";
  };
  propagatedBuildInputs = [
    Rcpp
    RcppArmadillo
    data_table
    dplyr
    tidyr
    purrr
    tibble
    Matrix
    rlang
  ];
}
