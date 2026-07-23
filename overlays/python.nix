# Injects the locally-packaged Python tools into `python3.pkgs`, so any shell
# can pull them in by name via `python3.withPackages` and their interdependencies
# (e.g. pyGenomeTracks -> pybedtools/gffutils/hicmatrix) resolve through the set.
final: prev: {
  python3 = prev.python3.override (old: {
    packageOverrides = prev.lib.composeExtensions (old.packageOverrides or (_: _: { })) (
      pyfinal: pyprev: {
        celluloid = pyfinal.callPackage ../pkgs/python/celluloid.nix { };
        hypernetx = pyfinal.callPackage ../pkgs/python/hypernetx.nix { };
        halp = pyfinal.callPackage ../pkgs/python/halp.nix { };
        pybedtools = pyfinal.callPackage ../pkgs/python/pybedtools.nix { };
        gffutils = pyfinal.callPackage ../pkgs/python/gffutils.nix { };
        cooler = pyfinal.callPackage ../pkgs/python/cooler.nix { };
        hicmatrix = pyfinal.callPackage ../pkgs/python/hicmatrix.nix { };
        crossmap = pyfinal.callPackage ../pkgs/python/crossmap.nix { };
        pyGenomeTracks = pyfinal.callPackage ../pkgs/python/pyGenomeTracks.nix { };
      }
    );
  });
}
