#gamescope -e --adaptive-sync -- steam -gamepadui Edit this configuration file to define what should be installed onbuild
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
	config,
	pkgs,
	pkgs-stable,
	inputs,
	options,
	lib,
	...
}: {
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		(import ./boot.nix {inherit config pkgs;})
		(import ./network.nix {inherit config pkgs;})
		(import ./greeter {inherit config pkgs;})
		(import ./services/git.nix {inherit config pkgs;})
		(import ./services/zsh.nix {inherit config pkgs;})
		(import ./services/tuned.nix {inherit config pkgs;})
		(import ./services/nvim.nix {inherit config pkgs;})
	];

	# Use latest kernel.
	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelParams = ["mem_sleep_default=deep"];
	};

	systemd.sleep.extraConfig = "SuspendState=mem";
	hardware.graphics.extraPackages = with pkgs; [
		intel-vaapi-driver
		intel-media-driver
	];

	virtualisation.virtualbox.host.enable = true;
	services.logind.settings.Login = {
		HandleLidSwitchDocked = "ignore";
		HandleLidSwitchExternalPower = "suspend";
		HandleLidSwitch = "suspend";
	};

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nix.optimise.automatic = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

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
	stylix.enable = true;

	hardware.graphics.enable = true;
	# hardware.xone.enable = true;
	# hardware.xpadneo.enable = true;

	services.udisks2.enable = true;
	# services = {
	# 	desktopManager.plasma6.enable = true;
	# 	displayManager.sddm.enable = true;
	#
	# 	displayManager.sddm.wayland.enable = true;
	# };

	# List packages installed in system profile. To search, run:
	environment.systemPackages = with pkgs; [
		ventoy-full-gtk
		mangowc
		mesa
		mesa-gl-headers
		gh
		os-prober
		arch-install-scripts
		alejandra
		fd
		gtk4
		gcc
		jdk
		canta-theme
		cage
		gamescope
		gamemode
		alsa-utils
		openvpn
		inputs.nix-alien.packages.${system}.default
		# (callPackage ./utils/nirius {})
		# (callPackage ./utils/mips {})
		bash
		jq
		# (callPackage ./utils/waterfox {})
		(callPackage ./utils/nvimunity {})
		(callPackage ./greeter/games/gamemode.nix {})
		(callPackage ./greeter/games/no-mans-sky.nix {})

		(let
			base = pkgs.appimageTools.defaultFhsEnvArgs;
		in
			pkgs.buildFHSEnv (base
				// {
					name = "fhs";
					targetPkgs = pkgs:
					# pkgs.buildFHSUserEnv provides only a minimal FHS environment,
					# lacking many basic packages needed by most software.
					# Therefore, we need to add them manually.
					#
					# pkgs.appimageTools provides basic packages required by most software.
						(base.targetPkgs pkgs)
						++ (
							with pkgs; [
								pkg-config
								ncurses
								gcc15
								# Feel free to add more packages here if needed.
							]
						);
					profile = "export FHS=1";
					runScript = "bash";
					extraOutputsToInstall = ["dev"];
				}))
		bibata-cursors
		xwayland-run
		astyle
		jdt-language-server
		vscode-extensions.vscjava.vscode-java-debug
		vscode-extensions.vscjava.vscode-java-test
		wine

		pkgs-stable.surge-XT
		x42-avldrums
		x42-plugins
		guitarix

		xorg.xauth
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-color-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		nerd-fonts.jetbrains-mono
		nerd-fonts.noto
		pixel-code
		comic-mono
		liberation_ttf
		font-awesome
	];

	services.flatpak.enable = true;

	services.flatpak.remotes =
		lib.mkOptionDefault [
			{
				name = "flathub-beta";
				location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
			}
		];

	services.flatpak.update.auto.enable = false;
	services.flatpak.uninstallUnmanaged = false;
	# Add flatpaks here
	services.flatpak.packages = [
		"net.waterfox.waterfox"
	];

	virtualisation.docker.enable = true;

	programs.nix-ld = {
		enable = true;
	};
	programs.steam.enable = true;

	programs.ssh = {
		setXAuthLocation = true;
		knownHosts = {
			# Alpha server
			alpha = {
				extraHostNames = ["192.168.86.29"];
				publicKey = "ssh-ed25519 AAAC3NzaC1lZDI1NTE5AAAAIAqYu29gfiO23YDDjJyNvgnMIEBH24qzR7QymsqOgSd3 fireye";
			};
		};
	};
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
	system.stateVersion = "25.05"; # Did you read the comment?
}
