{ config, pkgs, ...}:
let
  vars = import ../../../../core/system/variables.nix;
in
{

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  home-manager.sharedModules = [{
    home.file.".config/fastfetch/config.jsonc".text = ''
    {
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
    	"source": "~/.modular-nixos-configuration/external/theme/ascii-icon/rose.txt",
    	"type": "kitty",
    	"height": 18,
    	"padding": {
    		"top": 2
    	}
    },
    "display": {
        "separator": " "
    },
    "modules": [
        "break",
        "break",
        "break",
        {
                  "type": "custom",
                  "format": "\u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m"
              },
        "break",
        {
                  "type": "title",
                  "keyWidth": 10
              },
              "break",
              {
                  "type": "os",
                  "key": " ",
                  "keyColor": "34",  // = color4
              },
              {
                  "type": "kernel",
                  "key": " ",
                  "keyColor": "34",
              },
              {
                  "type": "packages",
                  "format": "{} (pacman)",
                  "key": " ",
                  "keyColor": "34",  
              },
              {
                  "type": "shell",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "terminal",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "wm",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "cursor",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "terminalfont",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "uptime",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "datetime",
                  "format": "{1}-{3}-{11}",
                  "key": " ",
                  "keyColor": "34", 
              },
              {
                  "type": "media",
                  "key": "󰝚 ",
                  "keyColor": "34", 
              },
              {
                  "type": "player",
                  "key": " ",
                  "keyColor": "34", 
              },
              "break",
              {
                  "type": "custom",
                  "format": "\u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m"
              },
              "break",
              "break",
          ]
      }
    '';
  }];
}
