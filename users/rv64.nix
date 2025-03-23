{ config, lib, pkgs, ... }:
let
  crossPkgs = pkgs.pkgsCross.riscv64;
in
{
  home.packages = with pkgs; [
    crossPkgs.ubootQemuRiscv64Smode
    crossPkgs.opensbi
    qemu
  ];
}
