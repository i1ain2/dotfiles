local package = require('core.pack').package

package({
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
})

package({
  'numToStr/Comment.nvim',
  lazy = false,
  opts = {}
})

