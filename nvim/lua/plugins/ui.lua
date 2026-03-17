return {
  -- Colorscheme: tokyonight is well-maintained and has great LSP/treesitter colours
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- load before all other plugins so colours are set first
    opts = {
      style = "night",
      transparent = false,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Icons: required by lualine and many other plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- only load when another plugin requests it
  },

  -- Statusline: lualine is fast and minimal
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "|",
        section_separators = "",
      },
    },
  },
}
