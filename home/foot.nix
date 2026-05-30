{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetbrainsMonoNerdFont:size=14";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
