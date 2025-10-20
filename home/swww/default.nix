{
	config,
	pkgs,
	...
}: let
	file =
		builtins.fetchurl {
			url = "https://github.com/LGFae/swww/blob/main/example_scripts/swww_randomize_multi.sh";
			sha256 = "";
		};
in {
	home.file = {
		".config/swww/bin/randomize_multi.sh" = {
			source = file;
			executable = true;
		};
	};
	services.swww.enable = true;
}
