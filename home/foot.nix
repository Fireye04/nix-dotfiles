{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
