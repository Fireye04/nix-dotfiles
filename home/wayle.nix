# put this into your home-manager config
{
	pkgs,
	lib,
	...
}: {
	# then you can use it as a normal program
	services.wayle = {
		enable = true;

		# tip: you can automatically translate your TOML config to Nix by running
		# nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
		settings = {
			modules = {
				clock = {
					format = "%H:%M:%S";
					dropdown-show-seconds = false;
				};
			};
		};
	};
}
