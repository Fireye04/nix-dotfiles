{
	config,
	pkgs,
	inputs,
}: {
	# import the home manager module
	imports = [
		inputs.noctalia.homeModules.default
	];

	# configure options
	programs.noctalia = {
		enable = true;
		settings = ./noctalia-config.toml;
	};
}
