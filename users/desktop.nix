
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
          show-per-app = true;
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
}
