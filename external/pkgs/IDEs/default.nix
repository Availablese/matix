{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # JAVA
    jetbrains.idea-ultimate
    javaPackages.compiler.openjdk23
    hsqldb
    scenebuilder
    
    # HTML / CSS / JS / PHP
    jetbrains.webstorm
    node2nix
    # jetbrains.phpstorm
    # php
    
    # RUST
    jetbrains.rust-rover
    gccgo14

    # Arduino
    avrdude
    arduino-ide
    
    # MSSQL
    azuredatastudio

    # Android
    androidStudioPackages.canary
    androidenv.androidPkgs.platform-tools
    

    # Python
    (python3.withPackages (
              python-pkgs: with python-pkgs; [
                pandas
                matplotlib
                numpy
                jupyterlab
              ]
            ))
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
  };

  programs.java = {
    enable = true;
    package = (pkgs.jdk21.override { enableJavaFX = true; });
  };

  environment.variables = {
    HSQLDB_JAR = "${pkgs.hsqldb}/share/java/hsqldb.jar";
  };
}
