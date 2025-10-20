{
	config,
	pkgs,
}: {
	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "Comic Mono:size=13";
			};
		};
	};
}
