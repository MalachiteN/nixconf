{ config, pkgs, ... }:
let
  libfprintPatched = pkgs.libfprint.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [ ./libfprint_synaptics_0169.patch ];
  });
  fprintdPatched = pkgs.fprintd.override { libfprint = libfprintPatched; };
in {
  environment.systemPackages = [ fprintdPatched ];
  services.fprintd = {
    enable = true;
    package = fprintdPatched;
  };
}
