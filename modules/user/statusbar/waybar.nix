{ config, lib, pkgs, ...}:

{
  imports = [
    ../../common/theme.nix
  ];

  programs.waybar = {
    enable = true;
  };
  
  # Cascading Style Sheet
  home.file.".config/waybar/style.css".text = 
  let
    vars = import ../../common/variables.nix;
  in ''
  * {
    border: none;
    border-radius: 0;
    font-family: Hack Nerd Font;
  }

  #battery,
  #clock,
  #wireplumber {
    padding: 0 10px;
    margin: 0 5px;
  }

  window#waybar {
    background: rgba(${vars.rgb}, ${vars.opacity});
    color: #${config.colorScheme.palette.base05};
    border-bottom: 2px solid #${config.colorScheme.palette.base03};
  }

  tooltip {
    background: #${config.colorScheme.palette.base00};
    border: 2px solid #${config.colorScheme.palette.base03};
  }

  #workspaces button {
    color: #${config.colorScheme.palette.base05};
  }

  #workspaces button.active {
    color: #${config.colorScheme.palette.base04};
    border-bottom: 2px solid #${config.colorScheme.palette.base04};
  }
  '';

  # Configuration
  home.file.".config/waybar/config.jsonc".text = ''
    {
      "layer": "top",
      "position": "top",

      "modules-left": [
	"hyprland/workspaces",
      ],

      "modules-center": [
	  "hyprland/window"
      ],

      "modules-right": [
        "wireplumber",
	"battery",
        "clock"
      ],

      "hyprland/window": {
          "format": "{}",
          "max-length": 50
      },

      "battery": {
          "format": "{icon} {capacity}%",
          "format-icons": ["󰂃", "󰂃", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
          "tooltip-format": "{time}"
      },

      "clock": {
          "format": "󱑆 {:%H:%M }",
          "format-alt": "󱑆 {:%a, %d. %b  %H:%M }",
     },

      "wireplumber": {
        "format": "{icon} {volume}% ",
        "format-muted": " ",
        "scroll-step": "1",
        "format-icons": ["", " ", " "]
      }
    }
  '';
}
