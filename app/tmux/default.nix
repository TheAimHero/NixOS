{ pkgs, ... }:
let
  tmux-nvim = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux.nvim";
    version = "da618e0";
    src = pkgs.fetchFromGitHub {
      owner = "aserowy";
      repo = "tmux.nvim";
      rev = "da618e0";
      sha256 = "Ie/aW08JgvuwDAEXWa+OQpouBGRUci2wa1ih54BuSwI=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    newSession = false;
    shortcut = "a";
    escapeTime = 1;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
      {
        plugin = tmux-nvim;
        extraConfig = ''
          set -g @tmux-nvim-navigation true
          set -g @tmux-nvim-navigation-cycle true
          set -g @tmux-nvim-navigation-keybinding-left 'C-h' 
          set -g @tmux-nvim-navigation-keybinding-down 'C-j' 
          set -g @tmux-nvim-navigation-keybinding-up 'C-k' 
          set -g @tmux-nvim-navigation-keybinding-right 'C-l' 
          set -g @tmux-nvim-resize false
        '';
      }

    ];
    extraConfig = builtins.readFile (./tmux.conf);
  };
}
