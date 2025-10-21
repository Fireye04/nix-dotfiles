{
	stdenv,
	system,
	pkgs,
}:
stdenv.mkDerivation {
	inherit system;
	name = "bash-gamemode";
	builder = "${pkgs.bash}/bin/bash";
	args = ["-c" ''touch "$out"''];
	outputs = ["out"];
	shellHook = ''
		gamescope -e --adaptive-sync -- steam -gamepadui"
	'';
}
