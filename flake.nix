{
  description = "FIU Parking and Transportation NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/server/configuration-server.nix
        ];
      };
    };
  };
}
