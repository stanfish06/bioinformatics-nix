{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  pyfaidx,
  matplotlib,
  intervaltree,
  pybigwig,
  pysam,
  tqdm,
  pytest,
  bx-python,
  pybedtools,
  gffutils,
  hicmatrix,
}:
buildPythonPackage rec {
  pname = "pyGenomeTracks";
  version = "3.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "deeptools";
    repo = "pyGenomeTracks";
    rev = "3.9";
    sha256 = "sha256-04OFjCoOma4qVELVfXdbNTfv5hQ9cK5CC61b3KQHXPU=";
  };

  build-system = [ setuptools ];

  # Upstream pins are stricter than the nixpkgs package set (e.g. matplotlib<3.9);
  # the previous manual `pip install --no-deps` never enforced them either.
  dontCheckRuntimeDeps = true;

  propagatedBuildInputs = [
    numpy
    pyfaidx
    matplotlib
    intervaltree
    pybigwig
    pysam
    tqdm
    pytest
    bx-python
    pybedtools
    gffutils
    hicmatrix
  ];

  doCheck = false;
}
