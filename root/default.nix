# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Bootloader.
	boot.loader = {
		grub = {
			enable = true;
			efiSupport = true;
			devices = ["nodev"];
			useOSProber = true;
			memtest86.enable = true;
			extraEntries = ''				
				menuentry "UEFI Settings" {fwsetup}'';

			#  extraEntries = ''menuentry "ARCH" {
			# set root=(hd0,gpt2)
			# linux /boot/vmlinuz-linux root=/dev/nvme0n1p2
			# initrd /boot/initramfs-linux.img
			# boot
			#
			#  }'';
		};

		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi";
		};
	};

	# Use latest kernel.
	boot.kernelPackages = pkgs.linuxPackages_latest;

	networking.hostName = "nixlaptop"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Pipewire
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true; # if not already enabled
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment the following
		#jack.enable = true;
	};

	#bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Experimental = true; # Show battery charge of Bluetooth devices
			};
		};
	};
	services.blueman.enable = true;
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
		extraGroups = ["networkmanager" "wheel"];
		packages = with pkgs; [
		];
	};

	hardware.graphics.enable = true;

	nix.settings.experimental-features = ["nix-command" "flakes"];

	# List packages installed in system profile. To search, run:
	environment.systemPackages = with pkgs; [
		gh
		os-prober
		arch-install-scripts
		alejandra
		fd
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

	environment.pathsToLink = ["/share/zsh"];
	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
		shellAliases = {
			update = "sudo nixos-rebuild switch";
			gaa = "git add --all";
			gc = "git commit";
			gp = "git push";
			gst = "git status";
		};
	};

	programs.git = {
		enable = true;
		config = {
			init = {
				defaultBranch = "main";
			};
			user.name = "Fireye";
			user.email = "codekai16@gmail.com";
		};
	};

	programs.nixvim = {
		enable = true;

		opts = {
			shiftwidth = 4;
			tabstop = 4;
			wrap = true;
			softtabstop = 4;
			expandtab = false;
			number = true;
			relativenumber = false;
		};

		globals = {
			mapleader = " ";
		};

		colorschemes.catppuccin.enable = true;

		dependencies.ripgrep.enable = true;

		clipboard.providers.wl-copy.enable = true;

		plugins = {
			lualine.enable = true;
			gitsigns.enable = true;
			treesitter.enable = true;
			which-key.enable = true;
			bufferline.enable = true;
			neo-tree.enable = true;

			web-devicons.enable = true;
			telescope.enable = true;
			mini-pairs.enable = true;
			lspconfig.enable = true;
			conform-nvim = {
				enable = true;
				settings = {
					formatters_by_ft = {
						# cs = { "clang_format" };
						python = ["ruff_format"];
						css = ["prettier"];
						nix = ["alejandra"];
					};
					format_on_save = {
						timeout_ms = 500;
					};
					formatters = {
						# clang_format = {
						# 	prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}", "--fallback-style=LLVM" },}
						# prettier = {
						# 	prepend_args = { "--use-tabs", "--tab-width", "4" },
						# },
					};
				};
			};
		};

		lsp.servers = {
			nixd.enable = true;
		};

		keymaps = [
			{
				action = "<cmd>Neotree toggle<CR>";
				key = "<leader>e";
			}
			{
				action = "<cmd>nohl<CR>";
				key = "<leader>q";
			}
		];
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
	system.stateVersion = "25.11"; # Did you read the comment?
}
