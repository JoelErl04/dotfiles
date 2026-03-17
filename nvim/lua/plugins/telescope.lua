return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Native C sorter — much faster than the Lua fallback on large projects
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
      },
    })

    -- Load the fzf sorter if it compiled successfully
    pcall(telescope.load_extension, "fzf")

    local map = vim.keymap.set

    -- Search keymaps — all under <leader>s to match kickstart convention
    map("n", "<leader>sf", builtin.find_files,  { desc = "Search files" })
    map("n", "<leader>sg", builtin.live_grep,   { desc = "Search by grep" })
    map("n", "<leader>sb", builtin.buffers,     { desc = "Search buffers" })
    map("n", "<leader>sh", builtin.help_tags,   { desc = "Search help" })
    map("n", "<leader>sr", builtin.oldfiles,    { desc = "Search recent files" })
    map("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
    map("n", "<leader>sk", builtin.keymaps,     { desc = "Search keymaps" })
    map("n", "<leader>ss", builtin.builtin,     { desc = "Search telescope pickers" })
    map("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })

    -- Resume last telescope search
    map("n", "<leader>s.", builtin.resume, { desc = "Resume last search" })
  end,
}
