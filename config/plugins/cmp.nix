{pkgs, ...}: {
  config = {
    options.completeopt = "menu,menuone,noselect";
    plugins = {
      luasnip = {
        enable = true;
        fromVscode = [{}];
      };
      lspkind = {
        enable = true;
        cmp.enable = true;
      };

      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-treesitter.enable = true;
      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      crates-nvim.enable = true;

      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        experimental = {
          ghost_text = true;
        };
        window = {
          completion = {};
          documentation = {};
        };
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
          "<Tab>" = {
            modes = ["i" "s"];
            action =
              # lua
              ''
                function(fallback)
                  local function has_words_before()
                    local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
                  end

                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback()
                  end
                end
              '';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action =
              # lua
              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                  else
                    fallback()
                  end
                end
              '';
          };
        };

        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}
          {name = "nvim_lua";}
          {name = "luasnip";}
          {name = "treesitter";}
          {name = "buffer";}
          {name = "path";}
          {name = "crates";}
        ];
      };
    };

    extraConfigLua = ''
      local cmp = require("cmp")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

        -- Use buffer source for `/`
      cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    '';
    extraPlugins = [pkgs.vimPlugins.friendly-snippets];
  };
}
