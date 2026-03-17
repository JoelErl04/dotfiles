return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local map = vim.keymap.set

		-- Add current file to harpoon list
		map("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file" })

		-- Toggle the harpoon quick menu
		map("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle menu" })

		-- Jump directly to files 1-4 without opening the menu
		map("n", "<C-1>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon file 1" })
		map("n", "<C-2>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon file 2" })
		map("n", "<C-3>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon file 3" })
		map("n", "<C-4>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon file 4" })

		-- Navigate through harpoon list sequentially
		map("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Next file" })
		map("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Prev file" })
	end,
}
