{ pkgs, inputs, settings, ...}:

{
  environment.systemPackages = with pkgs; [
    inputs.awww.packages.${pkgs.system}.awww
    (writeShellScriptBin "awww-start" ''
      #!/run/current-system/sw/bin/bash


      # Start awww daemon if not running
      pgrep -x awww >/dev/null || awww-daemon &

      sleep 1

      # Set your wallpaper
      awww img ~/.modular-nixos-configuration/external/theme/wallpaper/${settings.wallpaper} \
        --transition-type fade --transition-fps 60 --transition-duration 1
     '')
     (writeShellScriptBin "awww-on-workspace-changed" ''
      #!/run/current-system/sw/bin/bash

      # Slides your wallpaper
      awww img ~/.modular-nixos-configuration/external/theme/wallpaper/${settings.wallpaper} \
        --transition-type fade --transition-fps 60 --transition-duration 1
     '')
  ];
}
