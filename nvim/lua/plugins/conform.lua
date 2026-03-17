return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- load when saving so format-on-save works
	cmd = { "ConformInfo" }, -- also load if user runs :ConformInfo
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				python = { "black" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				go = { "gofmt" }, -- gofmt ships with Go, no mason needed
				lua = { "stylua" },
			},

			-- Format automatically on save
			format_on_save = {
				timeout_ms = 500, -- give formatter 500ms before giving up
				lsp_fallback = true, -- fall back to LSP formatting if no formatter found
			},
		})

		-- Manual format keymap (useful when you want to format without saving)
		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer" })
	end,
}
