{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetbrainsMonoNerdFont:size=13";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
