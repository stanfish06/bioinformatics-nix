{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  hatch-vcs,
  asciitree,
  click,
  cytoolz,
  h5py,
  multiprocess,
  numpy,
  pandas,
  pyfaidx,
  pyyaml,
  scipy,
  simplejson,
}:
buildPythonPackage rec {
  pname = "cooler";
  version = "0.10.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-HCVibVlwzt0f9lGWbDbZcHOml6eDDTabQ7LQ5ZzkBbo=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  propagatedBuildInputs = [
    asciitree
    click
    cytoolz
    h5py
    multiprocess
    numpy
    pandas
    pyfaidx
    pyyaml
    scipy
    simplejson
  ];

  doCheck = false;
}
