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
							rev = "efe40d460b495f6d5c2448eadcd3480002d4f12c";
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
