return {
	-- Gitsigns: shows added/changed/removed lines in the sign column
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			-- Show git blame for current line after 1 second
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 1000,
			},
		},
		config = function(_, opts)
			local gs = require("gitsigns")
			gs.setup(opts)

			local map = vim.keymap.set

			-- Hunk navigation
			map("n", "]h", gs.next_hunk, { desc = "Git: Next hunk" })
			map("n", "[h", gs.prev_hunk, { desc = "Git: Prev hunk" })

			-- Hunk actions
			map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
			map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
			map("n", "<leader>gb", gs.blame_line, { desc = "Blame line" })

			-- Visual mode: stage/reset selected lines only
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage selected lines" })
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset selected lines" })

			-- Telescope integration: browse commits and changed files
			map("n", "<leader>gc", require("telescope.builtin").git_commits, { desc = "Git commits" })
			map("n", "<leader>gf", require("telescope.builtin").git_bcommits, { desc = "Git file commits" })
			map("n", "<leader>gB", require("telescope.builtin").git_branches, { desc = "Git branches" })
		end,
	},

	-- Lazygit: full TUI inside nvim, reuses your existing lazygit config
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open Lazygit" },
		},
	},
}
