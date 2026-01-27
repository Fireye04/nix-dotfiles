{
	description = "My personal hell";

	inputs = {
		nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nixpkgs-small.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
		niri.url = "github:sodiboo/niri-flake";
		fix-python.url = "github:GuillaumeDesforges/fix-python";
		nix-alien.url = "github:thiagokokada/nix-alien";
		nix-citizen.url = "github:LovingMelody/nix-citizen";
		nix-flatpak.url = "github:gmodena/nix-flatpak";
		colmena.url = "github:zhaofengli/colmena";
		mango = {
			url = "github:DreamMaoMao/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			# The `follows` keyword in inputs is used for inheritance.
			# Here, `inputs.nixpkgs` of home-manager is kept consistent with
			# the `inputs.nixpkgs` of the current flake,
			# to avoid problems caused by different versions of nixpkgs.
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			# If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
			# inputs.nixpkgs.follows = "nixpkgs";
		};
		quickshell = {
			# add ?ref=<tag> to track a tag
			url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

			# THIS IS IMPORTANT
			# Mismatched system dependencies will lead to crashes and other issues.
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs-stable,
		nixpkgs,
		nixpkgs-small,
		niri,
		fix-python,
		nix-alien,
		nix-citizen,
		nix-flatpak,
		colmena,
		mango,
		stylix,
		home-manager,
		zen-browser,
		nixvim,
		quickshell,
		...
	} @ inputs: let
		system = "x86_64-linux";
		pkgs =
			import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = [
					niri.overlays.niri
					# (self: super: {
					# 		asm-lsp = pkgs.callPackage ./root/utils/mips/asm-lsp.nix {};
					# 	})
				];
				config.permittedInsecurePackages = [
					"ventoy-gtk3-1.1.10"
				];
			};
		pkgs-stable =
			import nixpkgs-stable {
				inherit system;
				config.allowUnfree = true;
				overlays = [];
				config.permittedInsecurePackages = [];
			};
		pkgs-small =
			import nixpkgs-small {
				inherit system;
				config.allowUnfree = true;
				overlays = [];
				config.permittedInsecurePackages = [];
			};
	in {
		nixosConfigurations = {
			nixlaptop =
				nixpkgs.lib.nixosSystem {
					inherit pkgs;
					system = "x86_64-linux";
					specialArgs = {
						pkgs-stable = pkgs-stable;
						pkgs-small = pkgs-small;
						inherit inputs;
					};
					modules = [
						./root
						stylix.nixosModules.stylix
						niri.nixosModules.niri
						mango.nixosModules.mango
						{
							programs.mango.enable = true;
						}
						nixvim.nixosModules.nixvim
						nix-flatpak.nixosModules.nix-flatpak

						home-manager.nixosModules.home-manager
						{
							home-manager.backupFileExtension = "backup";
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;

							home-manager.users.fireye = import ./home;

							# Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
							home-manager.extraSpecialArgs = {
								pkgs-stable = pkgs-stable;
								pkgs-small = pkgs-small;
								inherit inputs;
							};
						}
					];
				};
		};
	};
}
