
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
    "Xcursor.theme" = "Adwaita";
    "Xcursor.size" = "38";
  };

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-right = 10;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      widgets = [
        "buttons-grid"
        "mpris"
        "volume"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
          show-per-app = false;
        };
        buttons-grid.actions = [
          {
			label = "󰒲";
			command = "suspend";
          }
          {
			label = "󰜉";
			command = "reboot";
          }
          {
			label = "";
			command = "poweroff";
          }
          {
			label = "󰩈";
			command = "hyprctl dispatch exit";
          }
        ];
      };
    };
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
  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland.nix;
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/mala/Pictures/Wallpaper/Kath.png" ];
      wallpaper = [ ", /home/mala/Pictures/Wallpaper/Kath.png" ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
      };
      
      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
        ];
      };
      
      background = [
      {
        path = "/home/mala/Pictures/Wallpaper/Kath.png";
        blur_passes = 2;
      }
      ];
      
      shape = [
      {
        monitor = "";
        size = "640, 1340";
        halign = "left";
        valign = "top";
        position = "50,-50";
        rounding = 20;
        color = "rgba(255, 255, 255, 0.15)";
      }
      ];
      
      image = [
      {
        monitor = "";
        path = "/home/$USER/.face";
        size = 180;
        rounding = 20;
        halign = "left";
        valign = "center";
        position = "255, 150";
      }
      ];
      
      label = [
      {
        monitor = "";
        text = "$DESC";
        font_size = 26;
        font_family = "Fira Code Nerd Font";
        halign = "left";
        valign = "center";
        position = "185, 0";
      }
      {
        monitor = "";
        text = "$TIME";
        font_size = 130;
        font_family = "Sarasa Term SC";
        halign = "center";
        valign = "center";
        position = "345, 100";
      }
      ];

      input-field = [
      {
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        halign = "left";
        valign = "center";
        position = "150, -100";
      }
      ];
    };
  };
}
