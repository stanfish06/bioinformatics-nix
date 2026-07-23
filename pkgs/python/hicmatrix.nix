{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  numpy,
  scipy,
  tables,
  pandas,
  intervaltree,
  cooler,
}:
buildPythonPackage rec {
  pname = "hicmatrix";
  version = "17.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-ozMZCitg2Xjl/LOe/YdPypdjDNEsbljn5a2NcTnjIHg=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    numpy
    scipy
    tables
    pandas
    intervaltree
    cooler
  ];

  doCheck = false;
}
