{
  plugins.none-ls = {
    enable = true;

    sources = {
      formatting = {
        alejandra.enable = true;
        black.enable = true;
        isort.enable = true;
        gofmt.enable = true;
        rustfmt.enable = true;
        stylua.enable = true;
        shfmt.enable = true;
        taplo.enable = true;
        prettier.enable = true;
      };
      diagnostics = {
        deadnix.enable = true;
        shellcheck.enable = true;
        statix.enable = true;
      };
    };
    onAttach = ''
      function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = vim.api.nvim_create_augroup("LspFormatting", {}), buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", {}),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end
    '';
  };
}
