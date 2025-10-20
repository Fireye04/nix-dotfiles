{
	config,
	pkgs,
}: {
	programs.foot = {
		enable = true;
		settings = {
			font = "Comic Mono";
		};
	};
}
