{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "Pixel Code:size=13";
			};
			colors-dark = {
				blur = "yes";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
