# Injects the locally-packaged R tools into `rPackages` additively (a plain
# merge, so nixpkgs' own internal R overrides are left untouched). Dependencies
# — including the custom ones (archr -> chromVARmotifs/presto) — resolve through
# `final.rPackages`; `callPackageWith` pulls each file's declared args from that
# scope via intersectAttrs.
final: prev:
let
  callR = final.lib.callPackageWith (final // final.rPackages);
in
{
  rPackages = prev.rPackages // {
    presto = callR ../pkgs/r/presto.nix { };
    chromVARmotifs = callR ../pkgs/r/chromVARmotifs.nix { };
    archr = callR ../pkgs/r/archr.nix { };
  };
}
