{
  buildPythonPackage,
  fetchPypi,
  flit,
  matplotlib,
}:
buildPythonPackage rec {
  pname = "celluloid";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-VosVEsSpdIN1npQ2w/Pl3FVm2jUBeaoYcpkuyNgnBuE=";
  };

  build-system = [ flit ];

  propagatedBuildInputs = [ matplotlib ];

  doCheck = false;
}
