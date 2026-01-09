{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      rpkgs = with pkgs.rPackages; [
        ggplot2
        ggraph
        tidyverse
        ChIPseeker
        ComplexHeatmap
      ];
      python = pkgs.python312;

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
            future
            pysam
            tqdm
            pytest
            bx-python
          ]
          ++ [
            pkgs.deeptools
            pybedtools
            gffutils
            hicmatrix
          ];

        doCheck = false;
      };
    in
    {
      devShells.analysis = pkgs.mkShell {
        packages = with pkgs; [
          (rstudioWrapper.override { packages = rpkgs; })
          python
          (python.withPackages (
            ps: with ps; [
              numpy
              scipy
              pandas
              seaborn
              matplotlib
              statsmodels
              jupyterlab
              pyGenomeTracks
              deeptools
            ]
          ))
        ];
      };
    };
}
