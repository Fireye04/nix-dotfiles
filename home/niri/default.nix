{
	config,
	pkgs,
	inputs,
	...
}: {
	home.file = {
		".config/niri/bin/runtofi.sh" = {
			source = ./bin/runtofi.sh;
			executable = true;
		};
	};

	programs.niri = {
		# enable = true;
		package = pkgs.niri-unstable;

		config = with inputs.niri.lib.kdl; [
			(serialize.path ./config.kdl)
		];
	};
}
