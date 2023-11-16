{pkgs, ...}: {
  plugins = {
    gitsigns.enable = true;
    which-key.registrations = {
      "<leader>g" = "+git";
    };
  };
  extraPlugins = [pkgs.vimPlugins.lazygit-nvim];
  keymaps = [
    {
      key = "<leader>gr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options.desc = "Reset hunk";
      mode = ["n"];
    }
    {
      key = "<leader>gR";
      action = "<cmd>Gitsigns reset_buffer<CR>";
      options.desc = "Reset buffer";
      mode = ["n"];
    }
    {
      key = "<leader>gs";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options.desc = "Stage hunk";
      mode = ["n"];
    }
    {
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options.desc = "LazyGit";
      mode = ["n"];
    }
    {
      key = "<leader>gS";
      action = "<cmd>Gitsigns stage_buffer<CR>";
      options.desc = "Stage buffer";
      mode = ["n"];
    }
    {
      key = "]h";
      action = "<cmd>Gitsigns next_hunk<CR>";
      options.desc = "Next hunk";
      mode = ["n"];
    }
    {
      key = "[h";
      action = "<cmd>Gitsigns prev_hunk<CR>";
      options.desc = "Prev hunk";
      mode = ["n"];
    }
    {
      key = "<leader>gp";
      action = "<cmd>Gitsigns preview_hunk<CR>";
      options.desc = "Preview hunk";
      mode = ["n"];
    }
    {
      key = "<leader>gl";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options.desc = "Blame";
      mode = ["n"];
    }
    {
      key = "<leader>gd";
      action = "<cmd>Gitsigns diffthis<CR>";
      options.desc = "Diff";
      mode = ["n"];
    }
  ];
}
