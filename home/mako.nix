{
	config,
	pkgs,
	...
}: {
	services.mako = {
		enable = true;

		settings = {
			sort = "-time";
			layer = "overlay";
			background-color = "#2e3440";
			width = 300;
			height = 110;
			border-size = 2;
			border-color = "#88c0d0";
			border-radius = 15;
			icons = 0;
			max-icon-size = 64;
			default-timeout = 3000;
			ignore-timeout = 1;
			font = "monospace 12";
			anchor = "bottom-right";
			outer-margin = "0,20,35";
		};

		extraConfig = ''
			[urgency=low]
			border-color=#cccccc

			[urgency=normal]
			border-color=#d08770

			[urgency=high]
			border-color=#bf616a
			default-timeout=0

			[category=mpd]
			default-timeout=2000
			group-by=category
		'';
	};
}
