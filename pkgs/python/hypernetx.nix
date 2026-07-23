# NOTE: version 0.5.1 was never published to PyPI (releases skip from 0.2.x to
# 2.x), so this source cannot be fetched and the pin is invalid. The recipe is
# kept for reference but is intentionally excluded from the epigenomics shell
# and the flake's `packages` outputs pending a valid version pin.
{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  decorator,
  igraph,
  networkx,
  pandas,
  requests,
  scikit-learn,
  scipy,
  celluloid,
}:
buildPythonPackage rec {
  pname = "hypernetx";
  version = "0.5.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-acufTgcJ5I88d2/oMvkBBdc1lu3tUOIxVwGBhv+TkZQ=";
  };

  build-system = [ poetry-core ];

  propagatedBuildInputs = [
    decorator
    igraph
    networkx
    pandas
    requests
    scikit-learn
    scipy
    celluloid
  ];

  doCheck = false;
}
