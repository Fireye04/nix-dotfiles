{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs (oldAttrs: {
					src =
						pkgs.fetchFromCodeberg {
							owner = "dnkl";
							repo = "foot";
							tag = "1.25.0";
						};
				});
		enable = true;
		settings = {
			main = {
				font = "Pixel Code:size=13";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
