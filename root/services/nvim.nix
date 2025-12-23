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
			smarttab = true;
			tabstop = 4;
			wrap = true;
			softtabstop = 0;
			expandtab = true;
			number = true;
			relativenumber = false;
			clipboard = ["unnamedplus"];
		};

		globals = {
			mapleader = " ";
			clipboard = "wl-copy";
		};

		colorschemes.catppuccin.enable = true;

		dependencies.ripgrep.enable = true;

		clipboard.providers.wl-copy.enable = true;

		diagnostic.settings = {
			virtual_lines = true;
			virtual_text = false;
		};

		dependencies = {
			godot = {
				enable = true;
				package = pkgs.godot-mono;
			};
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

			# https://github.com/habamax/vim-godot/?tab=readme-ov-file#setup-neovim-as-an-external-editor-for-godot
			godot = {
				enable = true;
				settings = {
					executable = "godot-mono";
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
						cs = ["clang_format"];
						python = ["ruff_format"];
						rust = ["rustfmt"];
						css = ["prettier"];
						nix = ["alejandra"];
						java = ["astyle"];
						c = ["clang_format"];
					};
					format_on_save = {
						timeout_ms = 500;
					};
					formatters = {
						clang_format = {
							prepend_args = ["-style={BasedOnStyle: LLVM, IndentWidth: 4}" "--fallback-style=LLVM"];
						};
						# prettier = {
						# 	prepend_args = { "--use-tabs", "--tab-width", "4" },
						# },
					};
				};
			};
			friendly-snippets = {
				enable = true;
			};
			cmp = {
				enable = true;
				autoEnableSources = true;
				settings = {
					preselect = "cmp.PreselectMode.Item";
					sources = [
						{name = "nvim_lsp";}
						{name = "path";}
						{name = "buffer";}
						{name = "dictionary";}
						{name = "luasnip";}
					];
					snippet.expand = ''
						function(args)
							require("luasnip.loaders.from_vscode").lazy_load()
							require('luasnip').lsp_expand(args.body)
						end
					'';
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
			dap = {
				# enable = true;
				adapters = {
					servers = {
						# java = ''
						# 	require("jdtls.setup").add_commands()
						# 	require("dap.ext.vscode").load_launchjs()
						# 	require("jdtls.dap").setup_dap_main_class_configs()'';
					};
				};

				configurations = {
					# java = [
					# 	{
					# 		type = "java";
					# 		request = "attach";
					# 		name = "Connect";
					# 	}
					# ];
				};
			};

			dap-ui = {
				# enable = true;
			};
			dap-virtual-text = {
				# enable = true;
			};
			jdtls = {
				enable = true;
				settings = {
					cmd = [
						"jdtls"
					];
					init_options = {bundles = ["${pkgs.vscode-extensions.vscjava.vscode-java-debug}"];};
					root_dir = {__raw = "require('jdtls.setup').find_root({'.git', 'flake.nix'})";};
				};
			};
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
				pyright.enable = true;
				rust_analyzer.enable = true;
				qmlls.enable = true;
				gdscript.enable = true;
				clangd.enable = true;
				ccls.enable = true;
				ts_ls.enable = true;
				# asm_lsp = {
				# 	enable = true;
				# 	package = pkgs.asm-lsp;
				# };
				# gdshader_lsp.enable = true;

				# https://nix-community.github.io/nixvim/plugins/lsp/servers/omnisharp/index.html#omnisharp
				# https://gist.github.com/squk/055683bb83d4dbbac418582129f0e3b5
				# IF ITS ALL RED:
				# https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-messages/assembly-references#missing-references
				omnisharp = {
					config = {
						enableEditorConfigSupport = true;
						enableImportCompletion = true;
					};
					enable = true;
					package = pkgs.omnisharp-roslyn;
				};
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
				options.desc = "No Highlights";
			}
			{
				action = "<cmd>Telescope live_grep<CR>";
				key = "<leader>/";
				options.desc = "Grep directory";
			}
			{
				action = "<cmd>Telescope<CR>";
				key = "<leader>t";
				options.desc = "Open Telescope";
			}
			{
				action = "<cmd>Telescope fd<CR>";
				key = "<leader><leader>";
				options.desc = "Grep files";
			}
			{
				action = "<cmd>Telescope buffers<CR>";
				key = "<leader>b";
				options.desc = "Telescope buffers";
			}
			{
				action = "<cmd>BufferLineCycleNext<CR>";
				key = "<leader>l";
				options.desc = "Focus Next buffer";
			}
			{
				action = "<cmd>BufferLineCyclePrev<CR>";
				key = "<leader>h";
				options.desc = "Focus Previous buffer";
			}
			{
				action = "<cmd>BufferLineCloseOthers<CR>";
				key = "<leader>c";
				options.desc = "Clean buffers, leave current";
			}
			{
				action.__raw = ''require("lsp_lines").toggle'';
				key = "<Leader>p";
				options.desc = "Toggle lsp_lines";
			}
			{
				action = "\"_d";
				key = "<leader>d";
			}
		];

		extraPlugins = [
			(pkgs.vimUtils.buildVimPlugin {
					name = "vim-twee-sugarcube";
					src =
						pkgs.fetchFromGitHub {
							owner = "mcombeau";
							repo = "vim-twee-sugarcube";
							rev = "c514622b4a57f39ebb9c3adb9f2d0ba77fa1115a";
							hash = "sha256-D4RokTtPmc3b91nXc8sm4wBVvrVsrHFx8RkRQnjrXlE=";
						};
				})
		];
	};
	# imports = [
	# 	(import ../utils/mips/asm-format.nix {inherit config pkgs;})
	# ];
}
