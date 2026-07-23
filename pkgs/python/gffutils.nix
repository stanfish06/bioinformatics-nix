{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  pyfaidx,
  argh,
  argcomplete,
  simplejson,
}:
buildPythonPackage rec {
  pname = "gffutils";
  version = "0.13";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-sNUvNcAUzAMw+1xOPG/qEnyQzPTFOEqCXNtcj/Mw1Os=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    pyfaidx
    argh
    argcomplete
    simplejson
  ];

  doCheck = false;
}
