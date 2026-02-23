# PLACEHOLDER — replace with output of:
#   sudo nixos-generate-config --show-hardware-config
#
# Run this on the actual hardware after NixOS minimal install,
# then paste the output here.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot / filesystems — filled by nixos-generate-config
  # boot.initrd.availableKernelModules = [ ... ];
  # boot.kernelModules = [ ... ];
  # fileSystems."/" = { device = "/dev/disk/by-uuid/XXXX"; fsType = "ext4"; };
  # swapDevices = [ ... ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
