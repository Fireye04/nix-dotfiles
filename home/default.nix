{
	config,
	pkgs,
	lib,
	inputs,
	...
}: {
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

		hyfetch
		ranger
		waybar
		kitty
		gh
		autojump
		zsh-autosuggestions
		zsh-syntax-highlighting
		zsh-powerlevel10k
		xwayland-satellite
		pwvucontrol
		# inputs.zen-browser.packages.${system}.default
		niri-unstable
		slack
		spotify-player
		baobab
		networkmanagerapplet
		copyq
		signal-desktop
		tuned

		bibata-cursors

		# archives
		zip
		unzip

		# networking tools
		nmap # A utility for network discovery and security auditing

		# misc
		cowsay
		which
		gnupg

		# nix related
		#
		# it provides the command `nom` works just like `nix`
		# with more details log output
		nix-output-monitor

		# productivity
		hugo # static site generator

		btop # replacement of htop/nmon
		iotop # io monitoring
		iftop # network monitoring
	];

	imports = [
		(import ./niri {inherit config pkgs;})
		(import ./tofi {inherit lib config pkgs;})
		(import ./zen {inherit config pkgs inputs;})
		(import ./zsh {inherit lib config pkgs;})
		(import ./kitty {inherit config pkgs;})
		(import ./swww {inherit config pkgs;})
	];

	gtk.cursorTheme = {
		package = pkgs.bibata-cursors;
		name = "Bibata-MC";
	};

	# basic configuration of git, please change to your own
	programs.git = {
		enable = true;
		userName = "Fireye";
		userEmail = "codekai16@gmail.com";
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
