{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "bash-gamemode" ''gamescope -e --adaptive-sync -- steam -gamepadui''
