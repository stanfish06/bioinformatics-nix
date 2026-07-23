{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  zlib,
  numpy,
  pysam,
  pandas,
  bedtools,
}:
buildPythonPackage rec {
  pname = "pybedtools";
  version = "0.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-h4bsn2V5yBNjwAtDc0RDjfec8SiGDlyuJGaSYYFUckk=";
  };

  build-system = [
    setuptools
    cython
  ];

  buildInputs = [ zlib ];

  propagatedBuildInputs = [
    numpy
    pysam
    pandas
    bedtools
  ];

  doCheck = false;
}
