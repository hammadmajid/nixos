{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      /home/hammad/nixos/main.nix
    ];
}
