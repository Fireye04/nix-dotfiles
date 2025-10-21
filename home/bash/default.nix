{
	config,
	pkgs,
}: {
	programs.bash = {
		# bashrcExtra = "amixer sset Master unmute\n
		# 	amixer sset Speaker unmute\n
		# 	amixer sset Headphone unmute";
		shellAliases = {GS = "gamescope -e --adaptive-sync -- steam -gamepadui";};
	};
}
