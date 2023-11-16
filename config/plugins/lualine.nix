{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    disabledFiletypes.statusline = ["alpha" "neo-tree"];
    extensions = ["neo-tree"];
    sections = {
      lualine_a = ["mode"];
      lualine_b = ["branch" "diagnostics" "diff"];
      lualine_c = ["filename"];
      lualine_x = ["filetype"];
      lualine_y = ["progress"];
      lualine_z = ["location"];
    };
  };
}
