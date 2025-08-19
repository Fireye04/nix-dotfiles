{lib, ...}: let
	pkgs = import <nixpkgs> {};
	callPackage = lib.callPackageWith (pkgs // packages);
	packages = {
		nirius = callPackage ./nirius.nix {};
		slicer = callPackage ./slicer.nix {};
	};
in
	packages
