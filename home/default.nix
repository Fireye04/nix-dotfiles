{
	config,
	pkgs,
	pkgs-stable,
	lib,
	inputs,
	...
}: {
	imports =
		[
			(import ./bash.nix {inherit config pkgs;})
			(import ./zsh {inherit lib config pkgs;})
			(import ./swww {inherit config pkgs;})
			(import ./waybar {inherit config pkgs;})

			(import ./tofi.nix {inherit lib config pkgs;})
			(import ./zen.nix {inherit config pkgs inputs;})
			(import ./kitty.nix {inherit config pkgs;})
			(import ./foot.nix {inherit config pkgs;})
			(import ./mako.nix {inherit config pkgs;})
			(import ./niri {inherit config pkgs inputs;})
			(import ./mango.nix {inherit config pkgs inputs;})
		]
		++ [
			inputs.mango.hmModules.mango
		];

	home.username = "fireye";
	home.homeDirectory = "/home/fireye";

	# link the configuration file in current directory to the specified location in home directory
	# home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

	# link all files in `./scripts` to `~/.config/i3/scripts`
	# home.file.".config/i3/scripts" = {
	#   source = ./scripts;
	#   recursive = true;   # link recursively
	#   executable = true;  # make all files executable
	# };

	# encode the file content in nix configuration file directly
	# home.file.".xxx".text = ''
	#     xxx
	# '';

	# set cursor size and dpi for 4k monitor
	xresources.properties = {
		"Xcursor.size" = 12;
		"Xft.dpi" = 172;
	};

	# Packages that should be installed to the user profile.
	home.packages = with pkgs; [
		# here is some command line tools I use frequently
		# feel free to add your own or remove some of them
		glib
		dos2unix
		qmk
		gnome-clocks
		pkg-config-unwrapped
		gsettings-desktop-schemas
		dotnetCorePackages.sdk_9_0_1xx-bin
		rocmPackages.llvm.clang-unwrapped
		omnisharp-roslyn
		rustup
		xdg-desktop-portal
		xdg-desktop-portal-gtk
		xdg-desktop-portal-gnome
		libgnome-keyring
		nautilus
		unzip
		img2pdf
		udiskie
		cabextract
		unityhub
		plasticscm-client-core
		plasticscm-client-complete
		tor-browser
		yt-dlp
		pkgs-stable.etherpad-lite
		vlc
		kdePackages.kdenlive

		hyfetch
		anki
		ranger
		waybar
		kitty
		gh
		autojump
		tldr
		zsh-autosuggestions
		zsh-syntax-highlighting
		zsh-powerlevel10k
		xwayland-satellite
		pwvucontrol
		helvum
		# inputs.zen-browser.packages.${system}.default
		inputs.fix-python.packages.${system}.default
		inputs.quickshell.packages.${system}.default
		inputs.nix-citizen.packages.${system}.rsi-launcher
		inputs.colmena.packages.${system}.colmena
		(callPackage ../root/utils/nvimunity {})
		compose2nix
		niri-unstable
		slack
		spotify-player
		baobab
		kdePackages.dolphin
		networkmanagerapplet
		copyq
		signal-desktop
		tuned
		ffmpeg-full
		gnome-calculator
		obsidian
		hyprpicker
		wl-clipboard
		nirius
		nmap
		ardour
		cardinal

		# Communication
		thunderbird
		iamb
		jellyfin-tui
		jellyfin-desktop

		# fluffychat
		element-desktop

		zoom-us
		rocketchat-desktop

		# tools
		libreoffice
		gimp3
		obs-studio
		inkscape
		blender
		killall
		cmatrix
		lolcat
		pipes-rs

		# nix related
		#
		# it provides the command `nom` works just like `nix`
		# with more details log output
		nix-output-monitor
		dconf

		# productivity
		hugo # static site generator
		pkgs-stable.python313

		ruff
		gnumake
		uv
		gcc
		docker
		helm-docs

		btop # replacement of htop/nmon
		iotop # io monitoring
		iftop # network monitoring
		powertop
		brightnessctl
		playerctl
	];

	home.pointerCursor = {
		enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
	};
	dconf.settings = {
		"org/gnome/desktop/interface" = {
			cursor-theme = "Bibata-Modern-Classic";
		};
	};

	gtk = {
		enable = true;
		cursorTheme = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
		};
	};

	# basic configuration of git, please change to your own
	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Fireye";
				email = "codekai16@gmail.com";
			};
			alias = {
				lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
			};

			includeIf."gitdir:~/Work/".path = "~/.gitconfig-work";
		};
	};

	programs.gh = {
		enable = true;
		gitCredentialHelper = {
			enable = true;
		};
	};

	home.file = {
		".gitconfig-work" = {
			text = ''							
				[user]
					email = kkoehler@lsst.org
					name = Kai Koehler'';
		};
		".config/iamb/config.toml" = {
			text = ''
				[profiles.user]
				user_id = "@fireye-coffee:matrix.org"
			'';
		};
	};

	programs.btop = {
		enable = true;
		settings = {
			color_theme = "HotPurpleTrafficLight";
			theme_background = false;
		};
	};

	# This value determines the home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update home Manager without changing this value. See
	# the home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "25.05";
}
