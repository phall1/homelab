{
  description = "Jarvis — personal homelab on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs: {
    nixosConfigurations.jarvis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        sops-nix.nixosModules.sops
        ./machines/jarvis
        ./modules/common.nix
        ./modules/tailscale.nix
        ./modules/ollama.nix
        ./modules/docker.nix
        # Enable when ready:
        # ./modules/home-assistant.nix
      ];
    };
  };
}
