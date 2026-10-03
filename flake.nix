{
  description = "Rayyan Cyclegar's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    snappy-switcher = {
      url = "github:OpalAayan/snappy-switcher";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      chaotic,
      hyprland,
      home-manager,
      noctalia,
      noctalia-greeter,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { 
      	inherit system; 
	config.allowUnfree = true;
      };
    in
    {
      packages.${system} = {
        nuvio-desktop = import ./packages/nuvio-desktop.nix { inherit pkgs; };
        oblique-cursors = import ./packages/oblique-cursors.nix { inherit pkgs; };
      };

      nixosConfigurations.rayyanc-desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix

          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry

          noctalia-greeter.nixosModules.default

          noctalia.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { 
	    	inherit inputs;
		inherit pkgs-unstable;
	    };

            home-manager.users.rayyanc = import ./home/home.nix;
          }
        ];
      };
    };
}
