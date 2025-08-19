{lib, ...}: let
	pkgs = import <nixpkgs> {};
	callPackage = lib.callPackageWith (pkgs // packages);
	packages = {
		a = callPackage ./a.nix {};
		b = callPackage ./b.nix {};
		c = callPackage ./c.nix {};
		d = callPackage ./d.nix {};
		e = callPackage ./e.nix {};
	};
in
	packages
