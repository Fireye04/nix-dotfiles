{
	config,
	pkgs,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "Pixel Code:size=13";
			};
		};
	};
}
