{
	config,
	pkgs,
}: {
	programs.bash = {
		enable = true;
		# bashrcExtra = "amixer sset Master unmute\n
		# 	amixer sset Speaker unmute\n
		# 	amixer sset Headphone unmute";
		shellAliases = {
			GS = "gamescope -e --adaptive-sync -- steam -gamepadui";
		};
	};
}
