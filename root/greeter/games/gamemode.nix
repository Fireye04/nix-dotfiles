{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "bash-gamemode" ''gamescope -e -r 59 --adaptive-sync --hdr-enabled -- steam -gamepadui''
