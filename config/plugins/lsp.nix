{pkgs, ...}: {
  plugins = {
    navbuddy = {
      enable = true;
      lsp.autoAttach = true;
    };
    fidget.enable = true;
    lsp = {
      enable = true;
      preConfig = ''
        -- add additional capabilities supported by nvim-cmp
        -- nvim has not added foldingRange to default capabilities, users must add it manually
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
      '';
      postConfig = ''
        vim.diagnostic.config({
          update_in_insert = true,
          underline = true,
          signs = true,
        })
      '';
      servers = {
        bashls.enable = true;
        lua-ls.enable = true;
        pyright.enable = true;
        jsonls.enable = true;
        yamlls = {
          enable = true;
          extraOptions.capabilities.textDocument.foldingRange = {
            dynamicRegistration = false;
            lineFoldingOnly = true;
          };
        };
        nixd.enable = true;
        ruff-lsp.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        tsserver.enable = true;
        zls.enable = true;
        gopls.enable = true;
        nushell.enable = true;
      };
      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>cf" = "format";
          # other LSP functionality handled by LspSaga
        };
      };
    };
  };
  keymaps = [
    {
      key = "<leader>n";
      action = ":Navbuddy<CR>";
      options.desc = "Navbuddy";
      mode = ["n"];
    }
    {
      key = "<leader>cR";
      action = ":LspRestart<CR>";
      options.desc = "LspRestart";
      mode = ["n"];
    }
  ];
  autoCmd = [
    {
      event = ["BufNewFile" "BufRead"];
      pattern = ["*.nu"];
      command = "set ft=nu";
    }
  ];
}
