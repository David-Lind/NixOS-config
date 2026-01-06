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
    sshfs # Remote filesystems over SSH
    wl-clipboard # Clipboard Manager
    firefox
    zoom-us
    slack
    netron # visualize neural nets
    granted # AWS assume role
    pipx

    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];

  #home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

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
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      llvm-vs-code-extensions.vscode-clangd
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };
}
