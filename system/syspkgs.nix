{config, pkgs, ...}:
{
  # RISC-V Cross Compile
  nixpkgs.config.allowUnsupportedSystem = true;
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Clash
  programs.clash-verge.autoStart = true;
  programs.clash-verge.package = pkgs.clash-verge-rev;
  programs.clash-verge.enable = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gparted
    fcitx5-configtool
    rime-data
    libappindicator
    libdbusmenu
    python311
    gcc
    git
    git-credential-manager
    gh
    libsecret
    usbutils
    pciutils
    tree
    lsof
    oh-my-zsh
    brightnessctl
    swaynotificationcenter
    alacritty
    kitty
    hyprpolkitagent
    wofi
    waybar
    hyprpaper
    hyprshot
    hyprcursor
    hyprsysteminfo
    bluez
    bluez-tools
    cherry-studio
    rose-pine-hyprcursor
    #networkmanagerapplet
    jq
    bc
    socat
    gtk3
    libsForQt5.qt5.qtwayland
    wlr-protocols
    unzip
    nix-index
  ];

  #services.vnstat.enable = true;
  services.upower.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  virtualisation.docker = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "ys";
    };
  };

  programs.java.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.libc
      zlib
    ];
  };
  
  programs.nano.nanorc = ''
    set autoindent
    set linenumbers
    set tabsize 4
  '';
  
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    fontPackages = with pkgs; [ noto-fonts-cjk-sans ];
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  
}
