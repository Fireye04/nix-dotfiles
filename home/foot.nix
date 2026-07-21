{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetbrainsMonoNerdFont:size=11";
			};
			cursor = {
				style = "underline";
			};
			colors-dark = {
				blur = true;
			};
		};
	};
}
