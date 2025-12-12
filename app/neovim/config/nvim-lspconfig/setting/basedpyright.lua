vim.lsp.config('basedpyright', {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    Handlers.lsp_keymaps(bufnr)
  end,
  capabilities = Handlers.capabilities,
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportMissingTypeStubs = false,
        },
      },
    },
  },
})
vim.lsp.enable('basedpyright')
