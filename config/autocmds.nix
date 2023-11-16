{
  config = {
    autoCmd = [
      {
        event = "TextYankPost";
        command = ''lua vim.highlight.on_yank { higroup = "Visual", timeout = 200 }'';
      }
    ];
  };
}
