{ config, pkgs, settings, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprshot
  ];

  home-manager.sharedModules = [{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {};

    extraConfig = ''

      # Monitor Settings
      monitor=eDP-1,${settings.resolution},0x0,1
      monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1 # HDMI-A-1,1920x1080@60,0x0,1,mirror,eDP-1

      # Programs 
      $terminal = ${settings.terminal}
      $browser = ${settings.browser}
      # $fileManager = ${settings.fileManager}
      $menu = ${settings.menu} -show drun

      # Autostart
      exec-once = waybar & awww-start

      # Enviroment Variables
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24

      # General
      general { 
          gaps_in = 5
          gaps_out = 20

          border_size = ${settings.borderWidth}


          col.active_border = 0xff${config.lib.stylix.colors.base04}
          col.inactive_border = 0xff${config.lib.stylix.colors.base03}


          resize_on_border = true 


          allow_tearing = false

          layout = dwindle
      }

      decoration {
          rounding = ${settings.rounding}

          active_opacity = ${settings.opacity}
          inactive_opacity = ${settings.opacity}
          
          shadow {
              enabled = false
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)

          }

          blur {
              enabled = true
              size = 7
              passes = 4

              xray = true
              noise = 0.15
              
              contrast = 1
              vibrancy_darkness = 0.8
              brightness = 0.5
              vibrancy = 1
          }
      }

      animations {
          enabled = true

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      master {
          new_status = master
      }

      misc { 
          force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
          disable_splash_rendering = true
      }

      # Input
      input {
          kb_layout = ${settings.keyMap}
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = false
              disable_while_typing = false
          }
      }

      gestures {
          workspace = false
      }

      # Example per-device config
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

      # Keybinds

      $mainMod = SUPER # Sets "Windows" key as main modifier
      
      # Screenshots
      bind = $mainMod, PRINT, exec, hyprshot -m region

      # Apps
      bind = $mainMod, T, exec, $terminal
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, F, exec, $browser
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, H, togglefloating,
      bind = $mainMod, A, exec, $menu
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, G, fullscreen

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      # bind = $mainMod, S, togglespecialworkspace, magic
      # bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Window & Workspace Rules

      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      layerrule = blur,waybar
      layerrule = ignorezero,waybar
      layerrule = blur,wofi
      layerrule = blur,qutebrowser

      windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

      # Qutebrowser Transparency
      # windowrulev2 = opacity ${settings.opacity}, org.qutebrowser.qutebrowser:title:^(home - qutebrowser)$

      # Obsidian Transparence
      # windowrule = opacity ${settings.opacity}, ^(obsidian)$

      # Scene Builder
      windowrulev2 = stayfocused,class:^(com.oracle.javafx.scenebuilder.app.SceneBuilderApp)$
    '';
    };
  }];
}
