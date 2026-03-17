-- All settings -> lua/core/, all plugins -> lua/plugins/

-- Load core modules in order (options must come before keymaps)
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap lazy.nvim (auto-installs if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from lua/plugins/*.lua
require("lazy").setup({
  { import = "plugins" },
}, {
  change_detection = { notify = false },
})
