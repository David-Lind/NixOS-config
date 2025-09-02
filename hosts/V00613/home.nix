{
  pkgs,
  username,
  ...
}:
let
  homeDirectory = "/home/${username}";
in
{
  home = { inherit username homeDirectory; };

  home.packages = with pkgs; [
    # Tools
    swaybg # Wallpaper Tool
    sshfs # Remote filesystems over SSH
    wl-clipboard # Clipboard Manager
    firefox
    zoom-us
    slack

    granted # AWS assume role
  ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  programs = {
    git = {
      enable = true;
      userName = "David Lind";
      userEmail = "70724197+David-Lind@users.noreply.github.com";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    awscli = {
      enable = true;
    };
    zsh.shellAliases = {
      assume = "source assume";
    };
  };

}
