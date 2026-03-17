return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"python",
				"c",
				"cpp",
				"c_sharp",
				"javascript",
				"typescript",
				"tsx",
				"zig",
				"go",
				"html",
				"css",
				"json",
				"yaml",
				"toml",
				"markdown",
				"markdown_inline",
				"bash",
				"diff",
			},
		})

		-- Enable treesitter highlighting for every filetype that has a parser
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
			callback = function(event)
				pcall(vim.treesitter.start, event.buf)
			end,
			desc = "Enable treesitter highlighting",
		})

		-- Enable treesitter-based indentation
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_indent", { clear = true }),
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
			desc = "Enable treesitter indentation",
		})
	end,
}
