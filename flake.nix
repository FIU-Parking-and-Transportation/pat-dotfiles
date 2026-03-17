{
  description = "FIU Parking and Transportation NixOS configurations";

  inputs = {
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-dokploy.url = "github:el-kurto/nix-dokploy";
  };

  outputs = {
    disko,
    nix-dokploy,
    nixpkgs,
    self,
    ...
  }: {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/server/disk-config.nix
          disko.nixosModules.disko
          ./hosts/server/configuration-server.nix
          nix-dokploy.nixosModules.default
          {
            virtualisation.docker.enable = true;
            virtualisation.docker.daemon.settings.live-restore = false;
            services.dokploy = {
              enable = true;
              port = "3000:3000";
              database.passwordFile = "/var/lib/secrets/dokploy-db-password";
            };
          }
        ];
      };
    };
  };
}
