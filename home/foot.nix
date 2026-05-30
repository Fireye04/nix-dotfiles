{
	config,
	pkgs,
	pkgs-stable,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetbrainsMonoNerdFont:size=16";
			};
			cursor = {
				style = "underline";
			};
		};
	};
}
