{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};

      python = pkgs.python3;

      celluloid = python.pkgs.buildPythonPackage rec {
        pname = "celluloid";
        version = "0.2.0";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-VosVEsSpdIN1npQ2w/Pl3FVm2jUBeaoYcpkuyNgnBuE=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
          flit
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:${python.pkgs.flit}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs = with python.pkgs; [ matplotlib ];

        doCheck = false;
      };

      hypernetx = python.pkgs.buildPythonPackage rec {
        pname = "hypernetx";
        version = "2.4.0";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-acufTgcJ5I88d2/oMvkBBdc1lu3tUOIxVwGBhv+TkZQ=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
          poetry-core
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:${python.pkgs.poetry-core}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs =
          with python.pkgs;
          [
            decorator
            igraph
            networkx
            pandas
            requests
            scikit-learn
            scipy
          ]
          ++ [ celluloid ];

        doCheck = false;
      };

      halp = python.pkgs.buildPythonPackage rec {
        pname = "halp";
        version = "1.1";
        format = "other";

        src = pkgs.fetchFromGitHub {
          owner = "Murali-group";
          repo = "halp";
          rev = "1.1";
          sha256 = "sha256-pZVr9F0dwLvXJEtLraRAUxya9Eneu8FJNwC55KgVgGo=";
        };

        postPatch = ''
          substituteInPlace setup.py --replace-fail 'version="1.0.0"' 'version="${version}"'
        '';

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs = with python.pkgs; [
          numpy
          scipy
          networkx
        ];

        doCheck = false;
      };

      pybedtools = python.pkgs.buildPythonPackage rec {
        pname = "pybedtools";
        version = "0.12.0";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-h4bsn2V5yBNjwAtDc0RDjfec8SiGDlyuJGaSYYFUckk=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
          cython
        ];

        buildInputs = [ pkgs.zlib ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:${python.pkgs.cython}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs =
          with python.pkgs;
          [
            numpy
            pysam
            pandas
          ]
          ++ [ pkgs.bedtools ];

        doCheck = false;
      };

      gffutils = python.pkgs.buildPythonPackage rec {
        pname = "gffutils";
        version = "0.13";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-sNUvNcAUzAMw+1xOPG/qEnyQzPTFOEqCXNtcj/Mw1Os=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs = with python.pkgs; [
          pyfaidx
          argh
          argcomplete
          simplejson
        ];

        doCheck = false;
      };

      cooler = python.pkgs.buildPythonPackage rec {
        pname = "cooler";
        version = "0.10.4";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-HCVibVlwzt0f9lGWbDbZcHOml6eDDTabQ7LQ5ZzkBbo=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
          hatchling
          hatch-vcs
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:${python.pkgs.hatchling}/${python.sitePackages}:${python.pkgs.hatch-vcs}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs = with python.pkgs; [
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
      };

      hicmatrix = python.pkgs.buildPythonPackage rec {
        pname = "hicmatrix";
        version = "17.2";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-ozMZCitg2Xjl/LOe/YdPypdjDNEsbljn5a2NcTnjIHg=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs =
          with python.pkgs;
          [
            numpy
            scipy
            tables
            pandas
            intervaltree
          ]
          ++ [ cooler ];

        doCheck = false;
      };

      crossmap = python.pkgs.buildPythonPackage rec {
        pname = "crossmap";
        version = "0.7.3";
        format = "other";

        src = python.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-xXk9G7/qlis/IdjNmDCnmhabOj7GRhVV2Bm+Els5H20=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs = with python.pkgs; [
          pysam
          bx-python
          pybigwig
        ];

        doCheck = false;
      };

      pyGenomeTracks = python.pkgs.buildPythonPackage rec {
        pname = "pyGenomeTracks";
        version = "3.9";
        format = "other";

        src = pkgs.fetchFromGitHub {
          owner = "deeptools";
          repo = "pyGenomeTracks";
          rev = "3.9";
          sha256 = "sha256-04OFjCoOma4qVELVfXdbNTfv5hQ9cK5CC61b3KQHXPU=";
        };

        nativeBuildInputs = with python.pkgs; [
          setuptools
          wheel
          pip
        ];

        buildPhase = ''
          runHook preBuild
          export PYTHONPATH="${python.pkgs.setuptools}/${python.sitePackages}:${python.pkgs.wheel}/${python.sitePackages}:${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip wheel --no-deps --no-build-isolation --wheel-dir dist .
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          export PYTHONPATH="${python.pkgs.pip}/${python.sitePackages}:$PYTHONPATH"
          ${python}/bin/python -m pip install dist/*.whl --no-deps --prefix=$out
          runHook postInstall
        '';

        propagatedBuildInputs =
          with python.pkgs;
          [
            numpy
            pyfaidx
            matplotlib
            intervaltree
            pybigwig
            pysam
            tqdm
            pytest
            bx-python
          ]
          ++ [
            pybedtools
            gffutils
            hicmatrix
          ];

        doCheck = false;
      };
    in
    {
      devShells.epigenomics = pkgs.mkShell {
        packages = with pkgs; [
          samtools
          macs2
          bedtools
          deeptools
        ];
      };
    };
}
