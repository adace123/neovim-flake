{
  plugins.telescope = {
    enable = true;
    extraOptions = {
      defaults = {
        mappings = {
          i = {
            "<Esc>" = "close";
          };
        };
      };
      pickers.buffers = {
        show_all_buffers = "true";
        show_lastused = "true";
        theme = "dropdown";
        mappings = {
          i = {
            "<C-d>" = "delete_buffer";
          };
          n = {
            "dd" = "delete_buffer";
          };
        };
      };
    };
    keymaps = {
      "<leader>fb" = {
        action = "buffers";
        desc = "Buffers";
      };
      "<leader>fm" = {
        action = "marks";
        desc = "Marks";
      };
      "<leader>fd" = {
        action = "diagnostics";
        desc = "LSP Diagnostics";
      };
      "<leader>ff" = {
        action = "find_files";
        desc = "Files";
      };
      "<leader>fk" = {
        action = "keymaps";
        desc = "Keymaps";
      };
      "<leader>fj" = {
        action = "jumplist";
        desc = "Jumplist";
      };
      "<leader>fo" = {
        action = "oldfiles";
        desc = "Recent files";
      };
      "<leader>fc" = {
        action = "command_history";
        desc = "Command history";
      };
      "<leader>fg" = {
        action = "grep_string";
        desc = "Search word under cursor";
      };
    };
    extensions = {
      fzf-native.enable = true;
    };
  };
  keymaps = [
    {
      key = "<leader>fh";
      action = ":Telescope harpoon marks<CR>";
      options.desc = "Harpoon";
      mode = ["n"];
    }
    {
      key = "<leader>fC";
      action = "function() require('telescope.builtin').colorscheme({ enable_preview = true }) end";
      lua = true;
      options.desc = "Colorscheme";
      mode = ["n"];
    }
    {
      key = "<leader>fw";
      action = "function() require('telescope.builtin').live_grep({ find_command = {'rg', '--smart-case'} }) end";
      lua = true;
      options.desc = "Grep";
      mode = ["n"];
    }
  ];
}
