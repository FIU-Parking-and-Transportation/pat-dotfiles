{
  description = "FIU Parking and Transportation NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-dokploy.url = "github:el-kurto/nix-dokploy";
  };

  outputs = {
    self,
    nixpkgs,
    nix-dokploy,
    ...
  }: {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/server/configuration-server.nix
          nix-dokploy.nixosModules.default
          {
            virtualisation.docker.enable = true;
            virtualisation.docker.daemon.settings.live-restore = false;
            services.dokploy.enable = true;
          }
        ];
      };
    };
  };
}
