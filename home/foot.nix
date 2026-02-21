{
	config,
	pkgs,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs (oldAttrs: {
					src =
						pkgs.fetchFromCodeberg {
							owner = "dnkl";
							repo = "foot";
							rev = "e63150305ebe394960fbe386bed961f6aa5202dc";
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
