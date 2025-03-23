{config, pkgs, ...}:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Drivers
  hardware.firmware = with pkgs; [
    linux-firmware
  ];
}
