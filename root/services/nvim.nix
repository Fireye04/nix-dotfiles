{
	config,
	pkgs,
	...
}: {
	programs.nixvim = {
		enable = true;
		defaultEditor = true;

		opts = {
			shiftwidth = 4;
			tabstop = 4;
			wrap = true;
			softtabstop = 4;
			expandtab = false;
			number = true;
			relativenumber = false;
		};

		globals = {
			mapleader = " ";
		};

		colorschemes.catppuccin.enable = true;

		dependencies.ripgrep.enable = true;

		clipboard.providers.wl-copy.enable = true;

		diagnostic.settings = {
			virtual_lines = true;
			virtual_text = false;
		};

		plugins = {
			lualine.enable = true;
			gitsigns.enable = true;
			treesitter.enable = true;
			which-key.enable = true;
			bufferline.enable = true;
			neo-tree.enable = true;
			nvim-surround = {
				enable = true;
				settings.keymaps = {
					insert = "<C-g>s";
					insert_line = "<C-g>S";
					normal = "ys";
					normal_cur = "yss";
					normal_line = "yS";
					normal_cur_line = "ySS";
					visual = "S";
					visual_line = "gS";
					delete = "ds";
					change = "cs";
					change_line = "cS";
				};
			};

			web-devicons.enable = true;
			telescope.enable = true;
			mini-pairs.enable = true;
			lspconfig.enable = true;
			lsp-lines.enable = true;
			conform-nvim = {
				enable = true;
				settings = {
					formatters_by_ft = {
						# cs = { "clang_format" };
						python = ["ruff_format"];
						css = ["prettier"];
						nix = ["alejandra"];
					};
					format_on_save = {
						timeout_ms = 500;
					};
					formatters = {
						# clang_format = {
						# 	prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}", "--fallback-style=LLVM" },}
						# prettier = {
						# 	prepend_args = { "--use-tabs", "--tab-width", "4" },
						# },
					};
				};
			};
			cmp = {
				enable = true;
				autoEnableSources = true;
				settings = {
					sources = [
						{name = "nvim_lsp";}
						{name = "path";}
						{name = "buffer";}
						{name = "dictionary";}
					];
					mapping = {
						"<C-Space>" = "cmp.mapping.complete()";
						"<C-d>" = "cmp.mapping.scroll_docs(-4)";
						"<C-e>" = "cmp.mapping.close()";
						"<C-f>" = "cmp.mapping.scroll_docs(4)";
						"<CR>" = "cmp.mapping.confirm({ select = true })";
						"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
						"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
					};
				};
			};
			# cmp-nvim-lsp = {
			# 	enable = true;
			# };
			# cmp-dictionary = {
			# 	enable = true;
			# };
			# cmp-look = {
			# 	enable = true;
			# };
			# cmp-buffer = {
			# 	enable = true;
			# };
			# cmp-path = {
			# 	enable = true;
			# };
			# friendly-snippets = {
			# 	enable = true;
			# };
		};

		lsp = {
			inlayHints.enable = true;
			keymaps = [
				{
					key = "K";
					lspBufAction = "hover";
				}
			];
			servers = {
				nixd.enable = true;
				ruff.enable = true;
			};
		};

		keymaps = [
			{
				action = "<cmd>Neotree toggle<CR>";
				key = "<leader>e";
			}
			{
				action = "<cmd>nohl<CR>";
				key = "<leader>q";
			}
			{
				action = "<cmd>Telescope live-grep<CR>";
				key = "<leader>/";
			}
			{
				action = "<cmd>Telescope<CR>";
				key = "<leader><leader>";
			}
			{
				action = "<cmd>Telescope fd<CR>";
				key = "<leader>f";
			}
			{
				action.__raw = ''require("lsp_lines").toggle'';
				key = "<Leader>l";
				options.desc = "Toggle lsp_lines";
			}
		];
	};
}
