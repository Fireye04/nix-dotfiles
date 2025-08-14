{
  description = "My personal hell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, zen-browser, home-manager, niri, ...}@inputs:
  let
      system = "x86_64-linux";
  pkgs= import nixpkgs {
	inherit system;
	config.allowUnfree=true;
	overlays = [niri.overlays.niri];
  };
in {
    nixosConfigurations = {
    nixlaptop = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix 
		niri.nixosModules.niri
      	home-manager.nixosModules.home-manager {
	home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.fireye = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
	    home-manager.extraSpecialArgs = {inherit inputs;};
          }
	];
    };
    };
  };
}
