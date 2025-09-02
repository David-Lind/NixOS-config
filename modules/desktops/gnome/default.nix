{
  config,
  pkgs,
  lib,
  username,
  inputs,
  ...
}:
with lib;
let
  module_name = "gnome";
  cfg = config.desktops."${module_name}";
in
{
  options.desktops."${module_name}" = {
    enable = mkEnableOption "Enable the Gnome Compositor";
  };

  imports = [
    ../../home-manager.nix
  ];

  config = mkMerge [
    (mkIf cfg.enable {
      home-manager.users.${username} = {
        imports = [
          ./home.nix
        ];
      };

      # Gnome desktop config
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      services.gnome.core-apps.enable = true;
      services.gnome.core-developer-tools.enable = true;
      services.gnome.games.enable = false;
      environment.systemPackages = with pkgs; [ gnome-console ];
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
      ];

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      # Terminal Emulator
      configured.programs.zsh.enable = true;
      environment.shells = with pkgs; [ zsh ];

      # File Manager
      configured.programs.yazi.enable = true;
      # Pipewire
      configured.programs.pipewire.enable = true;

      # Bluetooth
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.caskaydia-cove
        noto-fonts
      ];

      # Git
      programs.git = {
        enable = true;
        config = {
          commit.gpgsign = builtins.any (
            conf: lib.hasAttrByPath [ "user" "signingkey" ] conf
          ) config.programs.git.config;
          core.autocrlf = "input";
        };
      };

      # Podman
      virtualisation.containers.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    })
    (mkIf config.impermanence.enable {
      environment.persistence."/persist" = {
        directories = [
          "/etc/NetworkManager/system-connections"
        ];
        users.${username}.directories = [
          ".gnupg"
        ];
      };
    })
  ];
}
