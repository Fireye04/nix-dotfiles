{
	config,
	pkgs,
	...
}: {
	home.file = {
		".config/sway/config" = {
			source = ./config;
		};
	};
}
