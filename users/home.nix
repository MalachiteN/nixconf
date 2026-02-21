{ config, lib, pkgs, ... }:
let
  wechatWithEnv = pkgs.symlinkJoin {
    name = "wechat-with-env";
    paths = [ pkgs.wechat ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/wechat \
        --set QT_IM_MODULE "fcitx" \
        --set GTK_IM_MODULE "fcitx" \
        --set XMODIFIERS "@im=fcitx"
    '';
  };
in
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
    wechatWithEnv
    eza
    btop
    onlyoffice-desktopeditors
    hyfetch
    fastfetch
    file
    nmap
    thc-hydra
    sqlmap
    vscode-fhs
    wl-clipboard
    vlc
    obsidian
    (texlive.combine {
      inherit (texlive) scheme-medium collection-langchinese collection-latexextra collection-latexrecommended;
    })
  ];
  
  programs.bat.enable = true;
 
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        proxyCommand = "nc -X connect -x 127.0.0.1:7897 %h %p";
      };
      "111.229.242.175" = {
        user = "mala";
      };
    };
  };
 
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "MalachiteN";
        email = "malachiten@163.com";
      };
      http.proxy = "http://127.0.0.1:7897";
      https.proxy = "http://127.0.0.1:7897";
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
    initContent = ''
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
