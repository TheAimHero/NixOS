{ pkgs, ... }:
let
  withLua = conf: conf;
  withLuaFile = file: builtins.readFile file;
  handlers = withLuaFile ./config/nvim-lspconfig/handlers.lua;

  # lsp config stuff
  defaultLspConfig =
    name:
    withLua ''
      vim.lsp.config( "${name}", {
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr)
          Handlers.lsp_keymaps(bufnr)
        end,
        capabilities = Handlers.capabilities,
      })
      vim.lsp.enable( "${name}" )
    '';
  tsserverCfg = withLuaFile ./config/nvim-lspconfig/setting/tsserver.lua;
  eslintCfg = withLuaFile ./config/nvim-lspconfig/setting/eslint.lua;
  goplsCfg = withLuaFile ./config/nvim-lspconfig/setting/gopls.lua;
  jsonlsCfg = withLuaFile ./config/nvim-lspconfig/setting/jsonls.lua;
  yamllsCfg = withLuaFile ./config/nvim-lspconfig/setting/yamlls.lua;
  pythonCfg = withLuaFile ./config/nvim-lspconfig/setting/basedpyright.lua;
  tailwindCfg = withLuaFile ./config/nvim-lspconfig/setting/tailwindcss.lua;
  clangdCfg = withLuaFile ./config/nvim-lspconfig/setting/clangd.lua;
  htmlCfg = withLuaFile ./config/nvim-lspconfig/setting/html.lua;
  luaLsCfg = withLuaFile ./config/nvim-lspconfig/setting/lua_ls.lua;
in
{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;
    initLua = ''
      ${builtins.readFile ./config/core/options.lua}
      ${builtins.readFile ./config/core/keymaps.lua}
      ${builtins.readFile ./config/core/disable.lua}
      ${builtins.readFile ./config/core/autocommands.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      plenary-nvim
      nui-nvim
      {
        plugin = neogit;
        type = "lua";
        config = withLuaFile ./config/plugins/neogit.lua;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/gitsigns.lua;
      }
      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = withLua ''require("nvim-ts-autotag").setup({})'';
      }
      telescope-undo-nvim
      substitute-nvim
      telescope-fzf-native-nvim
      friendly-snippets
      SchemaStore-nvim
      nvim-ts-context-commentstring
      vim-wakatime
      {
        plugin = octo-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/octo.lua;
      }
      {
        plugin = focus-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/focus.lua;
      }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/catppuccin.lua;
      }
      {
        plugin = mini-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/mini.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/telescope.lua;
      }
      {
        plugin = project-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/project.lua;
      }
      {
        plugin = eyeliner-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/eyeliner.lua;
      }
      {
        plugin = tmux-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/tmux.lua;
      }
      {
        plugin = yanky-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/substitute-yanky.lua;
      }
      {
        plugin = harpoon;
        type = "lua";
        config = withLuaFile ./config/plugins/harpoon.lua;
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/trouble.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = withLuaFile ./config/plugins/treesitter.lua;
      }
      {
        plugin = blink-cmp;
        type = "lua";
        config = withLuaFile ./config/completion/blink.lua;
      }
      {
        plugin = snacks-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/snacks-nvim.lua;
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = withLua ''require("nvim-surround").setup({})'';
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = withLuaFile ./config/plugins/copilot.lua;
      }
      {
        plugin = diffview-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/diffview.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/lualine.lua;
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/bufferline.lua;
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/neo-tree.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.concatStringsSep "\n" [
          handlers
          goplsCfg
          tailwindCfg
          pythonCfg
          eslintCfg
          jsonlsCfg
          yamllsCfg
          clangdCfg
          htmlCfg
          luaLsCfg
          tsserverCfg
          (defaultLspConfig "marksman")
          (defaultLspConfig "dockerls")
          (defaultLspConfig "docker_compose_language_service")
          (defaultLspConfig "nil_ls")
        ];
      }
      {
        plugin = conform-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/conform.lua;
      }
      {
        plugin = nvim-lint;
        type = "lua";
        config = withLuaFile ./config/plugins/nvim-lint.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = withLuaFile ./config/plugins/which-key.lua;
      }
    ];
    extraPackages = with pkgs; [
      lua-language-server
      typescript-language-server
      nil
      marksman
      basedpyright
      prettierd
      gopls
      vscode-langservers-extracted
      vscode-json-languageserver
      yaml-language-server
      nixpkgs-fmt
      golangci-lint-langserver
      golangci-lint
      pyright
      black
      stylua
      eslint_d
      dockerfile-language-server
      docker-compose-language-service
      tailwindcss-language-server
      actionlint
      sqlfluff
      zls
    ];
  };
}
