{lib, ...}: let
	self = with self; {
		callPackage = lib.callPackageWith self;

		nirius = callPackage ./nirius {lib = lib;};
		slicer = callPackage ./slicer {lib = lib;};
	};
in
	self
