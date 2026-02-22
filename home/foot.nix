{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs (oldAttrs: {
					version = "1.25.0b";
					src =
						pkgs.fetchFromCodeberg {
							owner = "Fireye";
							repo = "foot";
							tag = "1.25.0b";
							hash = "sha256-s7SwIdkWhBKcq9u4V0FLKW6CA36MBvDyB9ELB0V52O0=";
						};
				});
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
