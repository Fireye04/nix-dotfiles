# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
	config,
	pkgs,
	inputs,
	options,
	...
}: {
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		(import ./boot.nix {inherit config pkgs;})
		(import ./network.nix {inherit config pkgs;})
		(import ./greeter.nix {inherit config pkgs;})
		(import ./services/git.nix {inherit config pkgs;})
		(import ./services/zsh.nix {inherit config pkgs;})
		(import ./services/tuned.nix {inherit config pkgs;})
		(import ./services/nvim.nix {inherit config pkgs;})
		(import ./services/spot_player.nix {inherit config pkgs;})
	];

	# Use latest kernel.
	boot.kernelPackages = pkgs.linuxPackages_latest;

	nix.settings.experimental-features = ["nix-command" "flakes"];

	# Set your time zone.
	time.timeZone = "America/Phoenix";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.fireye = {
		isNormalUser = true;
		description = "fireye";
		extraGroups = ["networkmanager" "wheel" "docker"];
		packages = with pkgs; [
		];
	};

	hardware.graphics.enable = true;

	# List packages installed in system profile. To search, run:
	environment.systemPackages = with pkgs; [
		gh
		os-prober
		arch-install-scripts
		alejandra
		fd
		gtk4
		canta-theme
		cage

		bibata-cursors
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		nerd-fonts.jetbrains-mono
		nerd-fonts.noto
	];
	virtualisation.docker.enable = true;

	programs.nix-ld = {
		enable = true;
		libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [xorg.libSM xorg.libICE xorg.libXrender xorg.libXext xorg.libX11 xorg.libXcomposite xorg.libXdamage xorg.libXfixes xorg.libXrandr freetype expat fontconfig libGL libGLU glib libpulseaudio nss nspr]);
	};
	programs.steam.enable = true;
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
