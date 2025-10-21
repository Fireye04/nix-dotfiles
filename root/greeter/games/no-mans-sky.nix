{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "no-mans-sky" ''gamescope -e -r 59 --adaptive-sync --hdr-enabled -- steam steam://rungameid/275850''
