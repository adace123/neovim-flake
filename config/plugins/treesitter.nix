{pkgs, ...}: let
  nu-grammar = pkgs.tree-sitter.buildGrammar {
    language = "nu";
    version = "0.0.0+rev=358c4f5";
    src = pkgs.fetchFromGitHub {
      owner = "nushell";
      repo = "tree-sitter-nu";
      rev = "2d0dd587dbfc3363d2af4e4141833e718647a67e";
      hash = "sha256-A0Lpsx0VFRYUWetgX3Bn5osCsLQrZzg90unGg9kTnVg=";
    };
  };
in {
  filetype.extension.nu = "nu";
  plugins = {
    ts-autotag.enable = true;
    rainbow-delimiters.enable = true;
    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = true;
      indent = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "<CR>";
          nodeIncremental = "<CR>";
          scopeIncremental = "<S-CR>";
          nodeDecremental = "<BS>";
        };
      };
      grammarPackages = with pkgs;
        vimPlugins.nvim-treesitter.passthru.allGrammars
        ++ [nu-grammar];
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    nvim-treesitter-textobjects
  ];

  extraFiles = {
    "/queries/nu/highlights.scm" = builtins.readFile "${nu-grammar}/queries/nu/highlights.scm";
    "/queries/nu/injections.scm" = builtins.readFile "${nu-grammar}/queries/nu/injections.scm";
  };

  extraConfigLua = ''
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.nu = {
      filetype = "nu",
    }

    require("nvim-treesitter.parsers").get_parser_configs().just = {
        install_info = {
          url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
      },
      maintainers = { "@IndianBoy42" },
    }

      require'nvim-treesitter.configs'.setup {
      	textobjects = {
      		select = {
      			enable = true,
      			keymaps = {
      				["aa"] = "@parameter.outer",
      				["ia"] = "@parameter.inner",
      				["af"] = "@function.outer",
      				["if"] = "@function.inner",
      				["ac"] = "@class.outer",
      				["ic"] = "@class.inner",
      				["ai"] = "@conditional.outer",
      				["ii"] = "@conditional.inner",
      				["al"] = "@loop.outer",
      				["il"] = "@loop.inner",
      				["ak"] = "@block.outer",
      				["ik"] = "@block.inner",
      			},
      		},

      		move = {
      			enable = true,
      			set_jumps = true,
      			goto_next_start = {
      				["]m"] = "@function.outer",
      				["]c"] = "@class.outer",
      			},
      			goto_next_end = {
      				["]M"] = "@function.outer",
      				["]["] = "@class.outer",
      			},
      			goto_previous_start = {
      				["[m"] = "@function.outer",
      				["[c"] = "@class.outer",
      			},
      			goto_previous_end = {
      				["[M"] = "@function.outer",
      				["[]"] = "@class.outer",
      			},
      		},

      		swap = {
      			enable = true,
      			swap_next = {
      				[')a'] = '@parameter.inner',
      			},
      			swap_previous = {
      				[')A'] = '@parameter.inner',
      			},
      		},
      	},
      }

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  '';
}
