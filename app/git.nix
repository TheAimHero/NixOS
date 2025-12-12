{ pkgs, ... }: {
  programs.git = {
    enable = true;
    ignores = [ "Session.vim" ];
    settings = {
      user = {
        name = "TheAimHero";
        email = "91832491+TheAimHero@users.noreply.github.com";
      };
      core = {
        editor = "nvim";
        pager = "less -FX";
      };
      init.defaultBranch = "master";
      commit.verbose = true;
    };
  };
}
