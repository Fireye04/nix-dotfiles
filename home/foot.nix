{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetbrainsMonoNerdFont:size=12";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
