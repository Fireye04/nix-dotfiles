{
	description = "My personal hell";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		niri.url = "github:sodiboo/niri-flake";
		fix-python.url = "github:GuillaumeDesforges/fix-python";
		slicer = ./utils/slicer.nix;

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
			# url = "github:nix-community/nixvim/nixos-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs,
		niri,
		fix-python,
		home-manager,
		zen-browser,
		nixvim,
		...
	} @ inputs: let
		system = "x86_64-linux";
		pkgs =
			import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = [niri.overlays.niri];
			};
	in {
		nixosConfigurations = {
			nixlaptop =
				nixpkgs.lib.nixosSystem {
					inherit pkgs;
					system = "x86_64-linux";
					specialArgs = {inherit inputs;};
					modules = [
						./root
						niri.nixosModules.niri
						nixvim.nixosModules.nixvim
						home-manager.nixosModules.home-manager
						{
							home-manager.backupFileExtension = "backup";
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;

							home-manager.users.fireye = import ./home;

							# Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
							home-manager.extraSpecialArgs = {inherit inputs;};
						}
					];
				};
		};
	};
}
