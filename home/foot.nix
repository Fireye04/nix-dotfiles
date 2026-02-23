{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs
			(oldAttrs: {
					src =
						pkgs.fetchFromCodeberg {
							owner = "dnkl";
							repo = "foot";
							rev = "e63150305ebe394960fbe386bed961f6aa5202dc";
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
