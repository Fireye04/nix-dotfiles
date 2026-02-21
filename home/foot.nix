{
	config,
	pkgs,
}: {
	programs.foot = {
		package =
			pkgs.foot.overrideAttrs (oldAttrs: {
					src =
						pkgs.fetchGit {
							url = "https://codeberg.org/dnkl/foot";
							rev = "e63150305ebe394960fbe386bed961f6aa5202dc";
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
