{
	config,
	pkgs,
	...
}: {
	# Enable niri system wide so it shows up on the greeter session menu
	programs.niri = {
		package =
			pkgs.niri-unstable.override {
				src =
					pkgs.fetchFromGitHub {
						owner = "niri-wm";
						repo = "niri";
						rev = "f1e4091ab1de3bfe96bc8c927a7fdcf913d88fd0";
					};
			};

		enable = true;
	};
	programs.sway.enable = true;
	services.desktopManager.cosmic.enable = true;
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
		# {
		# 	manage = "desktop";
		# 	name = "Gamemode";
		# 	start = "gamescope -e -f -r 60 --backend wayland --mangoapp -- steam -nointro -bigpicture";
		# }
		# {
		# 	manage = "desktop";
		# 	name = "NoMansSky";
		# 	start = "gamescope -e -f -r 60 --backend wayland --mangoapp -- steam steam://rungameid/275850";
		# }
		{
			manage = "desktop";
			name = "StarCitizen";
			start = ''gamescope -r 165 --adaptive-sync --hdr-enabled -W 2560 -H 1600 rsi-launcher'';
		}
	];

	# DOES NOT WORK FOR REGREET
	#Add more envs on new lines
	# environment.etc."greetd/environments".text = ''
	# 	bash
	# 	bash-gamemode
	# '';
}
