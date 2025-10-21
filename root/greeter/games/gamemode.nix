{
	stdenv,
	pkgs,
}:
stdenv.mkDerivation {
	name = "bash-gamemode";
	src = pkgs.writeShellScript "bash-gamemode" ''gamescope -e --adaptive-sync -- steam -gamepadui'';
}
