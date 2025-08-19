{lib, ...}: let
	pkgs = import <nixpkgs> {};
	self = with self; {
		callPackage = lib.callPackageWith (self // pkgs);

		nirius = callPackage ./nirius {lib = lib;};
		slicer = callPackage ./slicer {lib = lib;};
	};
in
	self
