{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "bash-gamemode" ''gamescope -e -f -r 60 -mangohud -- steam -gamepadui''
