{
	config,
	pkgs,
	...
}: {
	home.file = {
		".config/awww/bin/randomize_multi.sh" = {
			source = ./bin/randomize_multi.sh;
			executable = true;
		};
	};
}
