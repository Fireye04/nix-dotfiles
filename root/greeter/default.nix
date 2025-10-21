{
	config,
	pkgs,
	...
}: {
	# Enable niri system wide so it shows up on the greeter session menu
	programs.niri = {
		enable = true;
		package = pkgs.niri-unstable;
	};
	services.greetd = {
		enable = true;
	};
	programs.regreet = {
		enable = true;
		cageArgs = ["-s" "-m" "last"];
		cursorTheme = {
			name = "Bibata-Modern-Classic";
			package = pkgs.bibata-cursors;
		};
		font = {
			name = "JetBrainsMonoNerdFont";
			size = 16;
			package = pkgs.nerd-fonts.jetbrains-mono;
		};
		theme = {
			name = "Canta-dark";
			package = pkgs.canta-theme;
		};
		settings = {
			background = {
				# Path to the background image
				path = "/etc/nixos/wallpapers/green_cabin.jpg";

				# How the background image covers the screen if the aspect ratio doesn't match
				# Available values: "Fill", "Contain", "Cover", "ScaleDown"
				# Refer to: https://docs.gtk.org/gtk4/enum.ContentFit.html
				# NOTE: This is ignored if ReGreet isn't compiled with GTK v4.8 support.
				fit = "Contain";
			};
			gtk = {
				application_prefer_dark_theme = true;
			};
			appearance = {
				greeting_msg = "Climb a tree! :3";
			};

			commands = {
				#BREAKS x11 SESSIONS (probably)
				x11_prefix = [""];
			};
		};
	};

	services.xserver.displayManager.session = [
		{
			manage = "desktop";
			name = "Gamemode";
			start = "gamescope -e -f -r 60 --sdr-gamut-wideness 1 --backend drm --mangoapp -- steam -nointro -bigpicture";
		}
	];

	# DOES NOT WORK FOR REGREET
	#Add more envs on new lines
	# environment.etc."greetd/environments".text = ''
	# 	bash
	# 	bash-gamemode
	# '';
}
