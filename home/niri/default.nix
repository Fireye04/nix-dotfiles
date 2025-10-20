{
	config,
	pkgs,
	inputs,
	...
}: let
	conf = pkgs.runCommand ''echo ${./config.kdl}'';
in {
	home.file = {
		".config/niri/bin/runtofi.sh" = {
			source = ./bin/runtofi.sh;
			executable = true;
		};
	};

	programs.niri = {
		# enable = true;
		package = pkgs.niri-unstable;

		config = conf;
	};
}
