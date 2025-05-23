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
    vlc
    (texlive.combine {
      inherit (texlive) scheme-medium collection-langchinese collection-latexextra collection-latexrecommended;
    })
  ];
  
  programs.bat.enable = true;
  
  programs.git = {
    enable = true;
    userName = "MalachiteN";
    userEmail = "malachiten@163.com";
    extraConfig = {
      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
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
        setsid -f "$@" >/dev/null 2>&1 
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
      eval "$(zellij setup --generate-auto-start zsh)"
    '';
  };
}
