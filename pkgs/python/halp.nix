{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  scipy,
  networkx,
}:
buildPythonPackage rec {
  pname = "halp";
  version = "1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Murali-group";
    repo = "halp";
    rev = "1.1";
    sha256 = "sha256-pZVr9F0dwLvXJEtLraRAUxya9Eneu8FJNwC55KgVgGo=";
  };

  postPatch = ''
    substituteInPlace setup.py --replace-fail 'version="1.0.0"' 'version="${version}"'
  '';

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    numpy
    scipy
    networkx
  ];

  doCheck = false;
}
