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
			hash = "sha256-IRtT/D2mx553IKCbakWbfVbMTYSEUX8OuSoha0pFV5Y=";
		};
	nativeBuildInputs = with pkgs; [
		unzip
	];

	unpackPhase = ''
	'';

	installPhase = ''
		      ls
		mkdir $out
		mv jetzig $out/bin
	'';
}
