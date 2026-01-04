local config = {}

function config.alpha()
  require("alpha").setup(require("alpha.themes.startify").config)
end

return config
