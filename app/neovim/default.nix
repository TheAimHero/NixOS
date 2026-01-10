{ pkgs, ... }:
let
  withLua = conf: "lua << EOF\n${conf}\nEOF\n";
  withLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
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
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          neocodeium = prev.vimUtils.buildVimPlugin {
            name = "neocodeium";
            src = pkgs.fetchFromGitHub {
              owner = "monkoose";
              repo = "neocodeium";
              rev = "bfe790d";
              sha256 = "SBUVCxJufLzWO/9ZOUOnpDBC2ez6DrvixgedMlXqKxI=";
            };
          };
          none-ls-extras = prev.vimUtils.buildVimPlugin {
            name = "none-ls-extras";
            src = pkgs.fetchFromGitHub {
              owner = "nvimtools";
              repo = "none-ls-extras.nvim";
              rev = "03955d1";
              sha256 = "Mm3BJI4wZ+Bzip2/A4l71MsGnGuITKTNDAMrxV8LleE=";
            };
            doCheck = false;
          };
        };
      })
    ];
  };

  home.packages = with pkgs; [
    codeium
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      ${builtins.readFile ./config/core/options.lua}
      ${builtins.readFile ./config/core/keymaps.lua}
      ${builtins.readFile ./config/core/disable.lua}
      ${builtins.readFile ./config/core/autocommands.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      plenary-nvim
      nui-nvim
      vim-fugitive
      {
        plugin = nvim-ts-autotag;
        config = withLua ''require("nvim-ts-autotag").setup({})'';
      }
      telescope-undo-nvim
      substitute-nvim
      telescope-fzf-native-nvim
      friendly-snippets
      cmp-nvim-lsp
      cmp-buffer
      cmp-async-path
      cmp-cmdline
      cmp_luasnip
      SchemaStore-nvim
      nvim-ts-context-commentstring
      vim-wakatime
      none-ls-extras
      octo-nvim
      {
        plugin = focus-nvim;
        config = withLuaFile ./config/plugins/focus.lua;
      }
      {
        plugin = catppuccin-nvim;
        config = withLuaFile ./config/plugins/catppuccin.lua;
      }
      {
        plugin = mini-nvim;
        config = withLuaFile ./config/plugins/mini.lua;
      }
      {
        plugin = telescope-nvim;
        config = withLuaFile ./config/plugins/telescope.lua;
      }
      {
        plugin = project-nvim;
        config = withLuaFile ./config/plugins/project.lua;
      }
      {
        plugin = eyeliner-nvim;
        config = withLuaFile ./config/plugins/eyeliner.lua;
      }
      {
        plugin = tmux-nvim;
        config = withLuaFile ./config/plugins/tmux.lua;
      }
      {
        plugin = yanky-nvim;
        config = withLuaFile ./config/plugins/substitute-yanky.lua;
      }
      {
        plugin = harpoon;
        config = withLuaFile ./config/plugins/harpoon.lua;
      }
      {
        plugin = trouble-nvim;
        config = withLuaFile ./config/plugins/trouble.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = withLuaFile ./config/plugins/treesitter.lua;
      }
      {
        plugin = nvim-cmp;
        config = withLuaFile ./config/completion/cmp.lua;
      }
      {
        plugin = luasnip;
        config = withLuaFile ./config/completion/luasnip.lua;
      }
      {
        plugin = snacks-nvim;
        config = withLuaFile ./config/plugins/snacks-nvim.lua;
      }
      {
        plugin = nvim-surround;
        config = withLua ''require("nvim-surround").setup({})'';
      }
      {
        plugin = neocodeium;
        config = withLuaFile ./config/plugins/codeium.lua;
      }
      {
        plugin = diffview-nvim;
        config = withLua "require('diffview').setup({})";
      }
      {
        plugin = lualine-nvim;
        config = withLuaFile ./config/plugins/lualine.lua;
      }
      {
        plugin = bufferline-nvim;
        config = withLuaFile ./config/plugins/bufferline.lua;
      }
      {
        plugin = neo-tree-nvim;
        config = withLuaFile ./config/plugins/neo-tree.lua;
      }
      {
        plugin = nvim-lspconfig;
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
        plugin = none-ls-nvim;
        config = withLuaFile ./config/nvim-lspconfig/none-ls.lua;
      }
    ];
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      nil
      marksman
      basedpyright
      prettierd
      gopls
      vscode-langservers-extracted
      nodePackages.vscode-json-languageserver
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
    ];
  };
}
