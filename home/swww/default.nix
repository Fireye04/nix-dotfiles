{
	config,
	pkgs,
	...
}: let
	file =
		pkgs.fetchFromGithub {
			url = "https://github.com/LGFae/swww/blob/main/example_scripts/swww_randomize_multi.sh";
			sha256 = "sha256:1mxqrxvyzg54xz2h453pk7pska3ggxq1za4flwladgqfphj8lnxc";
		};
in {
	home.file = {
		".config/swww/bin/randomize_multi.sh" = {
			source = file; # ./bin/randomize_multi.sh
			executable = true;
		};
	};
	services.swww.enable = true;
}
