{ config, pkgs, ... }:

{
  imports = [
    ./app/zsh
    ./app/tmux
    ./app/lf
    ./app/rofi
    ./app/neovim
    ./app/fzf.nix
    ./app/git.nix
    ./app/kitty.nix
    ./app/others.nix
  ];

  home = {
    username = "vedant";
    homeDirectory = "/home/vedant";
    packages = with pkgs; [
      pnpm
      lsd
      bat
      btop
      neofetch
      kitty
    ];
    file = { };
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      VISUAL = "nvim";
      SUDOEDIT = "nvim";
      PAGER = "bat";
      BROWSER = "firefox";
    };
    stateVersion = "24.05"; # Do not change this value.
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    cursors = {
      enable = true;
      flavor = "mocha";
      accent = "blue";
    };
  };
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
