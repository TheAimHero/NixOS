{ pkgs, ... }:
let
  myAliases = {
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    # confirm before overwriting something;
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";
    # Diffrent neovim configs;
    vi = "nvim --noplugins --cmd 'colorscheme habamax'";
    # quality remaps;
    cd = "z";
    xx = "exit";
    clr = "clear";
  };
  myKeybinds = builtins.readFile (./keybinds.sh);
  myConf = builtins.readFile (./zsh-conf.sh);
in
{
  programs = {
    zsh = {
      enable = true;
      shellAliases = myAliases;
      envExtra = builtins.readFile (./zsh-exports.sh);
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "0983009";
            sha256 = "yvPQyuK4Dw+LkwxrkWTRcw4PIf/79fW61jWbEg8Pe9Y=";
          };
        }
      ];
      initContent = builtins.concatStringsSep "\n" [
        myKeybinds
        myConf
      ];
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "tmux"
          "git"
          "vi-mode"
          "kind"
          "docker"
          "gh"
          "golang"
          "kubectl"
          "aws"
        ];
      };
    };
  };
}
