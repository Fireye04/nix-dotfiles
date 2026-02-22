{
	config,
	pkgs,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs (oldAttrs: {
					src =
						pkgs.fetchFromCodeberg {
							owner = "Fireye";
							repo = "foot";
							rev = "c291194a4e593bbbb91420e81fa0111508084448";
							hash = "sha256-mhjRqZcGkE/QGS3a7H5Veo/Ou95/5kZt54WUEFffK6w=";
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
