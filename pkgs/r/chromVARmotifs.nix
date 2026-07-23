# chromVARmotifs (GreenleafLab/chromVARmotifs) — GitHub only, ArchR Import.
{
  buildRPackage,
  fetchFromGitHub,
  TFBSTools,
}:
buildRPackage {
  name = "chromVARmotifs";
  src = fetchFromGitHub {
    owner = "GreenleafLab";
    repo = "chromVARmotifs";
    rev = "38bed559c1f4770b6c91c80bf3f8ea965da26076";
    hash = "sha256-uOTeryVTyUoFdRq2dSGE2+h5s7VFTntFmzS8DEMNO0U=";
  };
  propagatedBuildInputs = [ TFBSTools ];
}
