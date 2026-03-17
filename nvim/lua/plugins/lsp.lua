return {
	-- mason: installs LSP servers into a local data dir (not system-wide)
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	-- mason-lspconfig: bridges mason with nvim-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"pyright", -- Python
				"clangd", -- C / C++
				"zls", -- Zig
				"gopls", -- Go
				"ts_ls", -- TypeScript / JavaScript
				"html", -- HTML
			},
		},
	},

	-- nvim-lspconfig: provides defaults and server configs via vim.lsp.config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Tell each LSP server what the editor supports (snippets, etc.)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LspAttach fires every time an LSP server attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Navigation
					map("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
					map("gr", require("telescope.builtin").lsp_references, "Go to references")
					map("gi", require("telescope.builtin").lsp_implementations, "Go to implementation")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Go to type definition")

					-- Hover / signature
					map("K", vim.lsp.buf.hover, "Hover docs")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature help")

					-- Code actions
					map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")

					-- Diagnostics
					map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")

					-- Symbols via telescope
					map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "Search document symbols")
					map("<leader>sS", require("telescope.builtin").lsp_workspace_symbols, "Search workspace symbols")
				end,
			})

			-- Configure each server with capabilities using the new 0.11 API
			local servers = {
				"pyright",
				"clangd",
				"zls",
				"gopls",
				"ts_ls",
				"html",
			}
			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end

			-- Enable all configured servers
			vim.lsp.enable(servers)
		end,
	},

	-- nvim-cmp: completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
