{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pysam,
  bx-python,
  pybigwig,
}:
buildPythonPackage rec {
  pname = "crossmap";
  version = "0.7.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-xXk9G7/qlis/IdjNmDCnmhabOj7GRhVV2Bm+Els5H20=";
  };

  build-system = [
    setuptools
    cython
  ];

  propagatedBuildInputs = [
    pysam
    bx-python
    pybigwig
  ];

  doCheck = false;
}
