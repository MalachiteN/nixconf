{ config, lib, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./rv64.nix
  ];
  
  home.username = "mala";
  home.homeDirectory = "/home/mala";
  home.stateVersion = "24.11";
  
  home.packages = with pkgs; [
    qq
    vscode
    eza
    btop
    onlyoffice-desktopeditors
    hyfetch
    fastfetch
    file
    nmap
    thc-hydra
    sqlmap
    wl-clipboard
  ];
  
  home.file = let
    appImages = builtins.filter (file: lib.hasSuffix ".AppImage" file) (builtins.attrNames (builtins.readDir ./appimages));
    mkDesktop = pth:
      let
        baseName = lib.removeSuffix ".AppImage" (builtins.baseNameOf pth);
        desktop = "${baseName}.desktop";
      in
        {
          name = ".local/share/applications/${desktop}";
          value = { 
            text = ''
              [Desktop Entry]
              Type=Application
              Name=${baseName}
              Exec=/home/${config.home.username}/AppImages/${baseName}.AppImage
              Terminal=false
              StartupNotify=true
              X-GNOME-Autostart-enabled=true
            '';
            executable = true;
          };
        };
  in {
    
      "AppImages" = {
        source = ./appimages;
        executable = true;
        recursive = true;
      };

    } // builtins.listToAttrs (map mkDesktop appImages);

  programs.bat.enable = true;
  
  programs.git = {
    enable = true;
    userName = "MalachiteN";
    userEmail = "malachiten@163.com";
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    shellAliases = {
      nixconf = "cd /etc/nixos/";
      nixsys = "cd /etc/nixos/system/";
      nixusr = "cd /etc/nixos/users/";
      sn = "sudo nano";
    };
    initExtra = ''
      function sep {
        nohup "$@" >/dev/null 2>&1 & 
        disown
      }

      function cdcmd {
        local target=$(command -v "$1")
        if [[ -z "$target" ]]; then
          echo "Command not found: $1" >&2
          return 1
        fi
        while [[ -L "$target" ]]; do
          target=$(readlink "$target")
        done
        local dir=$(dirname `echo -n "$target"`)
        cd "$dir" || return 1
      }
    '';
  };
}
