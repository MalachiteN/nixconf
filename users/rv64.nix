{ config, lib, pkgs, ... }:
let
  crossPkgs = pkgs.pkgsCross.riscv64;
in
{
  home.packages = with pkgs; [
    qemu
  ];
}
