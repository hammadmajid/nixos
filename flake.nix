{
  description = "System config";

  inputs = {
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    unstable-nixpkgs,
  }: let
    unstable = unstable-nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.default = unstable.hello;
  };
}
