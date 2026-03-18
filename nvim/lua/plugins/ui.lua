return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local function palette()
        local p = {}
        local path = vim.fn.expand("~/.config/theme/colors.ini")
        for line in io.lines(path) do
          local k, v = line:match("^(%w+)%s*=%s*(%x+)$")
          if k and v then p[k] = "#" .. v end
        end
        return p
      end

      local c = palette()

      require("tokyonight").setup({
        style = "night",
        transparent = false,
        on_colors = function(colors)
          colors.bg             = c.background
          colors.bg_dark        = c.background
          colors.bg_float       = c.surface
          colors.bg_popup       = c.surface
          colors.bg_sidebar     = c.surface
          colors.bg_statusline  = c.surface
          colors.fg             = c.foreground
          colors.comment        = c.muted
          colors.border         = c.border_inactive
          colors.border_highlight = c.border_active
        end,
        on_highlights = function(hl, _)
          hl.FloatBorder            = { fg = c.border_inactive }
          hl.NormalFloat            = { bg = c.surface }
          hl.WinSeparator           = { fg = c.border_inactive }
          hl.TelescopeNormal        = { bg = c.surface }
          hl.TelescopeBorder        = { fg = c.border_active, bg = c.surface }
          hl.TelescopePromptNormal  = { bg = c.overlay }
          hl.TelescopePromptBorder  = { fg = c.border_active, bg = c.overlay }
          hl.TelescopeResultsNormal = { bg = c.surface }
          hl.TelescopePreviewNormal = { bg = c.surface }
          hl.TelescopeSelection     = { bg = c.overlay }
          hl.TelescopeMatching      = { fg = c.accent_secondary }
        end,
      })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

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
