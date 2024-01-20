{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.persistence-nvim];
  extraConfigLua = "require('persistence').setup()";
  plugins = {
    auto-session = {
      enable = false;
      autoSave.enabled = true;
    };

    alpha = {
      enable = true;
      iconsEnabled = true;
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          type = "text";
          opts = {
            hl = "Type";
            position = "center";
          };
          val = [
            "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
            "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
            "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
            "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
            "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
            "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        #   {
        #     type = "group";
        #     val = [
        #       {
        #         command = "<CMD>ene <CR>";
        #         desc = "  New file";
        #         shortcut = "e";
        #       }
        #       {
        #         command = "<CMD>:SessionRestore<CR>";
        #         desc = "󰦛 Restore Session";
        #         shortcut = "<leader>sr";
        #       }
        #       {
        #         command = "<CMD>:LastSessionRestore<CR>";
        #         desc = "󰦛 Restore Last Session";
        #         shortcut = "<leader>sR";
        #       }
        #       {
        #         command = "<CMD>:Telescope oldfiles<CR>";
        #         desc = "󰱽 Find File";
        #         shortcut = "<C-p>";
        #       }
        #       {
        #         command = "<CMD>:Telescope live_grep<CR>";
        #         desc = " Find in Files (grep)";
        #         shortcut = "<leader>fg";
        #       }
        #       {
        #         command = "<CMD>:LazyGit<CR>";
        #         desc = " LazyGit";
        #         shortcut = "<leader>gg";
        #       }
        #       {
        #         command = ":qa<CR>";
        #         desc = "󰗼  Quit Neovim";
        #         shortcut = "<leader>q";
        #       }
        #     ];
        #   }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "text";
          opts = {
            hl = "Keyword";
            position = "center";
          };
          val = "Inspiring quote here.";
        }
      ];
    };
  };
}
