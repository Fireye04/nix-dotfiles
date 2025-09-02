{
	config,
	pkgs,
	...
}: {
	# home.file = {
	# 	".config/swww/bin/randomize_multi.sh" = {
	# 		source = ./bin/randomize_multi.sh;
	# 		executable = true;
	# 	};
	# };
	programs.quickshell = {
		enable = true;
		config = {
		};
	};
}
