{config, pkgs, inputs, ...}:
{
  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    sarasa-gothic
    wqy_zenhei
    noto-fonts-emoji
    inputs.apple-emoji-nix.packages.x86_64-linux.apple-emoji-nix
    pkgs.nerd-fonts.fira-code
  ];
  fonts.fontconfig.defaultFonts = {
    sansSerif = ["Noto Sans CJK SC" "WenQuanYi Zen Hei" "Sarasa Gothic SC"];
    serif = ["Noto Serif CJK SC"];
    emoji = ["Apple Color Emoji" "Noto Color Emoji"];
    monospace = ["FiraCode Nerd Font" "Sarasa Mono SC" "Noto Sans Mono CJK SC"];
  };
}
