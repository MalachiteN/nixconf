{config, pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mala = {
    isNormalUser = true;
    description = "Marisa Malachite";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "audio" ];
    home = "/home/mala";
    shell = pkgs.zsh;
  };
}
