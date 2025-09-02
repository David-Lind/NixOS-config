{ pkgs, lib, inputs, username, ... }:
let
  homeDirectory = "/home/${username}";
  inherit (lib) mkMerge mkIf;
in
{
  home = { inherit username homeDirectory; };
  home.packages = with pkgs; [
    nautilus
    seahorse

    # Clipboard utilities
    # Needed to make Vim use global clipboard
    wl-clipboard
    
    # Backlight control
    light
  ];

  # Terminal Emulator
  programs.foot.enable = true;
  programs.foot.settings = {
    main = {
      font = "monospace:size=11";
      dpi-aware = "yes";
    };
    colors = {
      alpha = 0.9;

      # Kanagawa Dragon
      foreground = "c5c9c5";
      background = "181616";

      selection-foreground = "C8C093";
      selection-background = "2D4F67";

      regular0 = "0d0c0c";
      regular1 = "c4746e";
      regular2 = "8a9a7b";
      regular3 = "c4b28a";
      regular4 = "8ba4b0";
      regular5 = "a292a3";
      regular6 = "8ea4a2";
      regular7 = "C8C093";

      bright0  = "a6a69c";
      bright1  = "E46876";
      bright2  = "87a987";
      bright3  = "E6C384";
      bright4  = "7FB4CA";
      bright5  = "938AA9";
      bright6  = "7AA89F";
      bright7  = "c5c9c5";

      "16"     = "b6927b";
      "17"     = "b98d7b";
    };
  };

  # GPG & Password Store
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-gtk2;
    extraConfig = ''
      allow-preset-passphrase
    '';
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    iconTheme = {
      package = pkgs.dracula-icon-theme;
      name = "Dracula";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
