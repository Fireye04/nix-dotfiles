{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    # home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, zen-browser, ...}@inputs: {
    nixosConfigurations.fireye = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
