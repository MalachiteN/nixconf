
{ config, lib, pkgs, ... }:
{
  xresources.properties = {
    "Xft.dpi" = "153";
    "Xft.autohint" = "0";
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = "1";
    "Xft.antialias" = "1";
    "Xft.rgba" = "rgb";
    "Xcursor.theme" = "Rose Pine";
    "Xcursor.size" = "38";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "Rose Pine";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      mouse = {
        bindings = [
          {
            mouse = "Right";
            action = "Paste";
          }
        ];
      };
      selection = {
        save_to_clipboard = true;
      };
      window = {
        opacity = 0.8;
        decorations = "Full";
      };
    };
  };
}
