local pack = {}
pack.__index = pack

function pack:load_modules_packages()
  local modules_dir = self.helper.path_join(self.config_path, 'lua', 'modules')
  self.repos = {}

  local list = vim.fs.find('package.lua', { path = modules_dir, type = 'file', limit = 10 })
  if #list == 0 then
    return
  end

  local disable_modules = {}

  if vim.fn.exists('g:disable_modules') == 1 then
    disable_modules = vim.split(vim.g.disable_modules, ',', { trimempty = true })
  end

  for _, f in pairs(list) do
    local _, pos = f:find(modules_dir)
    f = f:sub(pos - 6, #f - 4)
    if not vim.tbl_contains(disable_modules, f) then
      require(f)
    end
  end
end


function pack:boot_strap()
  self.helper = require('core.helper')
  self.data_path = self.helper.data_path()
  self.config_path = self.helper.config_path()
  local lazypath = self.helper.path_join(self.data_path, 'lazy', 'lazy.nvim')
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
  local lazy = require('lazy')
  local opts = {
    defaults = {
      lazy = true,
    },
    lockfile = self.helper.path_join(self.data_path, 'lazy-lock.json'),
  }
  self:load_modules_packages()
  lazy.setup(self.repos, opts)

  for k, v in pairs(self) do
    if type(v) ~= 'function' then
      self[k] = nil
    end
  end
end

function pack.package(repo)
  if not pack.repos then
    pack.repos = {}
  end
  table.insert(pack.repos, repo)
end

return pack
