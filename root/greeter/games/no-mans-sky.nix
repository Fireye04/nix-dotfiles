{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "bash-gamemode" ''gamescope -e -r 59 --adaptive-sync --hdr-enabled -- steam steam://rungameid/275850''
