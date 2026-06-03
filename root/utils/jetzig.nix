{
	pkgs,
	stdenv,
	fetchurl,
	...
}:
stdenv.mkDerivation {
	name = "libfoo-1.2.3";
	src =
		fetchurl {
			url = "https://www.jetzig.dev/downloads/build-linux.zip";
			hash = "";
		};
	nativeBuildInputs = with pkgs; [
		unzip
	];

	unpackPhase = ''
		unzip build-linux.zip -d jetzig
	'';

	installPhase = ''
		mkdir $out
		mv jetzig $out/bin
	'';
}
