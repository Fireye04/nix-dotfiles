{
	config,
	pkgs,
	inputs,
	...
}: let
	conf = toString pkgs.runCommand ''cat ${./config.kdl} >> $out'';
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
