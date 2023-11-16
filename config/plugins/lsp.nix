{pkgs, ...}: {
  plugins = {
    navbuddy = {
      enable = true;
      lsp.autoAttach = true;
    };
    navic.enable = true;
    fidget.enable = true;
    lsp = {
      enable = true;
      onAttach = ''
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "rounded",
              source = "always",
              prefix = " ",
              scope = "line",
            }
            vim.diagnostic.show()
            vim.diagnostic.open_float(nil, opts)
          end,
        })
      '';
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
        yamlls.enable = true;
        nixd.enable = true;
        ruff-lsp.enable = true;
        rust-analyzer.enable = true;
        tsserver.enable = true;
        zls.enable = true;
        gopls.enable = true;
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };
        lspBuf = {
          "gK" = "signature_help";
          "ca" = "code_action";
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
  ];
  extraPlugins = [pkgs.vimPlugins.nvim-nu];
  extraConfigLua = ''
    -- set up nvim-nu
    require("nu").setup()

    -- show diagnostics when InsertLeave
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "rust", "nix", "haskell" },
      callback = function(args)
        vim.api.nvim_create_autocmd("DiagnosticChanged", {
          buffer = args.buf,
          callback = function()
            vim.diagnostic.hide()
          end,
    })

    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
          buffer = args.buf,
            callback = function()
              vim.diagnostic.show()
            end,
        })
      end,
    })
  '';
}
