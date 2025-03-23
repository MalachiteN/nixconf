{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-emoji-nix = {
      url = "github:oxcl/apple-emoji-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, apple-emoji-nix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
      	./configuration.nix
      	
      	home-manager.nixosModules.home-manager

      	{
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.mala = import ./users/home.nix;
          };
      	}
      ];
    };
  };
}
