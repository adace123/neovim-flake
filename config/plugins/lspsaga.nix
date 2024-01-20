{
  plugins = {
    which-key.registrations = {
      "<leader>c" = "code+";
    };
    lspsaga = {
      enable = true;
      lightbulb.sign = false;
      scrollPreview = {
        scrollDown = "<C-j>";
        scrollUp = "<C-k>";
      };
      finder.keys.toggleOrOpen = "<CR>";
    };
  };
  keymaps = [
    {
      key = "gr";
      action = "<cmd>Lspsaga finder<CR>";
      options.desc = "Lsp finder";
      mode = ["n"];
    }
    {
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options.desc = "Code action";
      mode = ["n"];
    }
    {
      key = "<leader>cr";
      action = "<cmd>Lspsaga rename ++project<CR>";
      options.desc = "Rename word in project";
      mode = ["n"];
    }
    {
      key = "<leader>cf";
      action = "function() vim.lsp.buf.format() end";
      lua = true;
      options.desc = "Format";
      mode = ["n"];
    }
    {
      key = "gD";
      action = "<cmd>Lspsaga peek_definition<CR>";
      options.desc = "Peek definition";
      mode = ["n"];
    }
    {
      key = "gd";
      action = "<cmd>Lspsaga goto_definition<CR>";
      options.desc = "Goto definition";
      mode = ["n"];
    }
    {
      key = "<leader>cd";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options.desc = "Line diagnostics";
      mode = ["n"];
    }
    {
      key = "<leader>cD";
      action = "<cmd>Lspsaga show_buf_diagnostics<CR>";
      options.desc = "Buffer diagnostics";
      mode = ["n"];
    }
    {
      key = "[d";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options.desc = "Previous diagnostic";
      mode = ["n"];
    }
    {
      key = "]d";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options.desc = "Next diagnostic";
      mode = ["n"];
    }
    {
      key = "K";
      action = "<cmd>Lspsaga hover_doc ++keep<CR>";
      options.desc = "Hover doc";
      mode = ["n"];
    }
    {
      key = "<leader>cO";
      action = "<cmd>Lspsaga outline<CR>";
      options.desc = "Toggle outline";
      mode = ["n"];
    }
    {
      key = "<leader>ci";
      action = "<cmd>Lspsaga incoming_calls<CR>";
      options.desc = "Incoming calls";
      mode = ["n"];
    }
    {
      key = "<leader>co";
      action = "<cmd>Lspsaga outgoing_calls<CR>";
      options.desc = "Outgoing calls";
      mode = ["n"];
    }
  ];
}
