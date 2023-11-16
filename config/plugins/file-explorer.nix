{
  plugins.neo-tree = {
    enable = true;
    addBlankLineAtTop = true;
    closeIfLastWindow = true;
    enableDiagnostics = true;
    enableGitStatus = true;
    autoCleanAfterSessionRestore = true;
    window.mappings = {
      "e".__raw = "function() vim.api.nvim_exec('Neotree filesystem', true) end";
      "b".__raw = "function() vim.api.nvim_exec('Neotree buffers', true) end";
      "g".__raw = "function() vim.api.nvim_exec('Neotree git_status', true) end";
    };
    filesystem = {
      followCurrentFile.enabled = true;
      filteredItems = {
        visible = true;
        hideDotfiles = false;
        hideByName = [
          ".git"
          ".node_modules"
        ];
      };
    };
  };

  keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>e";
      options.desc = "Neotree";
      mode = ["n"];
    }
  ];
}
