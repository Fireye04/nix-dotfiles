{
	config,
	pkgs,
	...
}: {
	programs.kitty = {
		enable = true;
		font = {
			name = "JetbrainsMonoNerdFont";
			package = pkgs.nerd-fonts.jetbrains-mono;
		};
		shellIntegration.enableZshIntegration = true;
		settings = {
			clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
			cursor_shape = "underline";
			cursor_underline_thickness = 1.0;
			background = "#222436";

			#: black
			# color0 #000000
			# color8 #767676

			#: red
			# color1 #cc0403
			# color9 #f2201f

			#: green
			color2 = "#47b413";
			color10 = "#35d450";

			#: yellow
			# color3  #cecb00
			# color11 #fffd00

			#: blue
			# color4  #0d73cc
			# color12 #1a8fff

			#: magenta
			# color5  #cb1ed1
			# color13 #fd28ff

			#: cyan
			color6 = "#13c299";
			color14 = "#24dfc4";

			#: white
			# color7  #dddddd
			# color15 #ffffff
		};
	};
}
