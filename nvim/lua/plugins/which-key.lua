return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- load after startup so it doesn't slow initial open
  opts = {
    delay = 300, -- ms after leader before popup appears (matches timeoutlen)
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register leader group prefixes so which-key shows categories
    wk.add({
      { "<leader>s", group = "Search (Telescope)" },
      { "<leader>c", group = "Code (LSP)" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lazy" },
      { "<leader>h", group = "Harpoon" },
    })
  end,
}
