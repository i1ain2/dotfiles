local keymap = require("core.keymap")
local nmap, imap, cmap, vmap, xmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.vmap, keymap.xmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-------------------------------------- Leader Key ------------------------------------------
vim.g.mapleader = " "
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

-------------------------------------- Helper Functions ------------------------------------
local function move_down()
  return vim.v.count > 0 and "j" or "gj"
end

local function move_up()
  return vim.v.count > 0 and "k" or "gk"
end

-------------------------------------- Basic Keymaps ---------------------------------------
nmap({
  -- Clear highlights
  { "<Esc>", ":noh <CR>", opts(noremap, silent, "Clear highlights") },
  -- Window navigation
  { "<C-h>", "<C-w>h", opts(noremap, "Move Left") },
  { "<C-l>", "<C-w>l", opts(noremap, "Move right") },
  { "<C-j>", "<C-w>j", opts(noremap, "Move down") },
  { "<C-k>", "<C-w>k", opts(noremap, "Move up") },
  -- Save and quit
  { "<leader>w", cmd("w"), opts(noremap, "Save file") },
  { "<leader>W", cmd("w!"), opts(noremap, "Save file forcibly") },
  { "<leader>q", cmd("q"), opts(noremap, "quit neovim") },
  { "<leader>Q", cmd("qa"), opts(noremap, "quit all") },
  -- Line numbers
  { "<leader>ln", cmd("set nu!"), opts(noremap, silent, "Toggle line number") },
  { "<leader>lr", cmd("set rnu!"), opts(noremap, silent, "Toggle relative number") },
  -- Cursor movement (wrapped lines)
  { "j", move_down(), opts(noremap, expr, "Move down") },
  { "k", move_up(), opts(noremap, expr, "Move up") },
  { "<Down>", move_down(), opts(noremap, expr, "Move down") },
  { "<Up>", move_up(), opts(noremap, expr, "Move up") },
  -- Buffer navigation
  { "<Tab>", cmd("bnext"), opts(noremap, silent, "Goto next buffer") },
  { "<S-Tab>", cmd("bprev"), opts(noremap, silent, "Goto prev buffer") },
  { "<leader>x", cmd("bdelete"), opts(noremap, silent, "Close buffer") },
  { "<leader>b", cmd("enew"), opts(noremap, silent, "New buffer") },
  -- Quickfix
  { "[q", cmd("cprevious"), opts(noremap, silent, "previous quickfix") },
  { "]q", cmd("cnext"), opts(noremap, silent, "next quickfix") },
  { "[Q", cmd("cfirst"), opts(noremap, silent, "first quickfix") },
  { "]Q", cmd("clast"), opts(noremap, silent, "last quickfix") },
})

vmap({
  -- Cursor movement (wrapped lines)
  { "j", move_down(), opts(noremap, expr, "Move down") },
  { "k", move_up(), opts(noremap, expr, "Move up") },
  { "<Down>", move_down(), opts(noremap, expr, "Move down") },
  { "<Up>", move_up(), opts(noremap, expr, "Move up") },
})

-------------------------------------- Plugin: Comment -------------------------------------
nmap({
  {
    "<leader>/",
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    opts(noremap, silent, "Toggle comment"),
  },
})

vmap({
  {
    "<leader>/",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    opts(noremap, silent, "Toggle comment"),
  },
})

-------------------------------------- Plugin: Telescope -----------------------------------
nmap({
  { "<leader>ff", cmd("Telescope find_files theme=ivy"), opts(noremap, silent, "Find files") },
  {
    "<leader>fa",
    cmd("Telescope find_files follow=true no_ignore=true hidden=true theme=ivy"),
    opts(noremap, silent, "Find all"),
  },
  { "<leader>fw", cmd("Telescope live_grep theme=ivy"), opts(noremap, silent, "Live grep") },
  { "<leader>fb", cmd("Telescope buffers theme=ivy"), opts(noremap, silent, "Find buffers") },
  { "<leader>fh", cmd("Telescope help_tag theme=ivy"), opts(noremap, silent, "Help page") },
  {
    "<leader>fz",
    cmd("Telescope current_buffer_fuzzy_find theme=ivy"),
    opts(noremap, silent, "Find in current buffer"),
  },
  -- neoclip
  { "<C-y>", cmd("Telescope neoclip"), opts(noremap, silent, "open yank history") },
})

-------------------------------------- Plugin: oil.nvim ------------------------------------
nmap({
  { "<leader>e", cmd("Oil"), opts(noremap, silent, "open file explorer") },
})

-------------------------------------- Plugin: FTerm ---------------------------------------
nmap({
  { "<C-\\><C-t>", '<Cmd>lua require("FTerm").toggle()<CR>', opts(noremap, silent, "toggle terminal") },
})

vmap({
  { "<C-\\><C-t>", '<Cmd>lua require("FTerm").toggle()<CR>', opts(noremap, silent, "toggle terminal") },
})

xmap({
  { "<C-\\><C-t>", '<Cmd>lua require("FTerm").toggle()<CR>', opts(noremap, silent, "toggle terminal") },
})

imap({
  { "<C-\\><C-t>", '<Cmd>lua require("FTerm").toggle()<CR>', opts(noremap, silent, "toggle terminal") },
})

tmap({
  { "<C-\\><C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts(noremap, silent, "toggle terminal") },
})

-------------------------------------- Plugin: Sidekick (AI Assistant) ---------------------
local function sidekick_toggle_claude()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end

nmap({
  { "<leader>aa", function() require("sidekick.cli").toggle() end, opts(noremap, silent, "Sidekick Toggle CLI") },
  { "<leader>as", function() require("sidekick.cli").select() end, opts(noremap, silent, "Select CLI") },
  { "<leader>ad", function() require("sidekick.cli").close() end, opts(noremap, silent, "Detach CLI Session") },
  { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, opts(noremap, silent, "Send This") },
  { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, opts(noremap, silent, "Send File") },
  { "<leader>ap", function() require("sidekick.cli").prompt() end, opts(noremap, silent, "Sidekick Select Prompt") },
  { "<C-\\><C-a>", sidekick_toggle_claude, opts(noremap, silent, "Sidekick Toggle Claude") },
})

vmap({
  { "<C-\\><C-a>", sidekick_toggle_claude, opts(noremap, silent, "Sidekick Toggle Claude") },
})

xmap({
  { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, opts(noremap, silent, "Send This") },
  { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, opts(noremap, silent, "Send Visual Selection") },
  { "<leader>ap", function() require("sidekick.cli").prompt() end, opts(noremap, silent, "Sidekick Select Prompt") },
  { "<C-\\><C-a>", sidekick_toggle_claude, opts(noremap, silent, "Sidekick Toggle Claude") },
})

imap({
  { "<C-\\><C-a>", sidekick_toggle_claude, opts(noremap, silent, "Sidekick Toggle Claude") },
})

tmap({
  { "<C-\\><C-a>", '<C-\\><C-n><CMD>lua require("sidekick.cli").toggle({ name = "claude", focus = true })<CR>', opts(noremap, silent, "Sidekick Toggle Claude") },
})

-------------------------------------- Plugin: LSP -----------------------------------------
nmap({
  { "K", cmd("Lspsaga hover_doc"), opts(noremap, silent, "LSP hover") },
  { "<C-s>f", cmd("Lspsaga lsp_finder"), opts(noremap, silent, "LSP finder") },
  { "<C-s>D", cmd("lua vim.lsp.buf.declaration()"), opts(noremap, silent, "LSP declaration") },
  { "<C-s>i", cmd("lua vim.lsp.buf.implemention()"), opts(noremap, silent, "LSP implemention") },
  { "<C-s>d", cmd("lua vim.lsp.buf.definition()"), opts(noremap, silent, "LSP definition") },
  { "<C-s>t", cmd("lua vim.lsp.buf.type_definition()"), opts(noremap, silent, "LSP definition type") },
  { "<C-s>r", cmd("lua vim.lsp.buf.references()"), opts(noremap, silent, "LSP references") },
  { "<C-s>p", cmd("Lspsaga peek_definition"), opts(noremap, silent, "LSP peek definition") },
  { "<leader>fm", cmd("lua vim.lsp.buf.format{async=true}"), opts(noremap, silent, "LSP formatting") },
  { "<C-s>c", cmd("Lspsaga code_action"), opts(noremap, silent, "LSP code action") },
  { "<F2>", cmd("Lspsaga rename"), opts(noremap, silent, "LSP rename") },
  { "<C-s>g", cmd("Lspsaga show_line_diagnostics"), opts(noremap, silent, "LSP diagnostic") },
  { "<C-s>e", cmd("lua vim.diagnostic.setloclist()"), opts(noremap, silent, "Diagnostic setloclist") },
  { "[e", cmd("Lspsaga diagnostic_jump_prev"), opts(noremap, silent, "Goto prev diagnostic") },
  { "]e", cmd("Lspsaga diagnostic_jump_next"), opts(noremap, silent, "Goto next diagnostic") },
})

-------------------------------------- Plugin: Trouble -------------------------------------
nmap({
  {
    "<leader>xx",
    function()
      require("trouble").toggle()
    end,
    opts(noremap, silent, "toggle trouble"),
  },
  {
    "<leader>xw",
    function()
      require("trouble").toggle("workspace_diagnostics")
    end,
    opts(noremap, silent, "toggle workspace diagnostics"),
  },
  {
    "<leader>xd",
    function()
      require("trouble").toggle("document_diagnostics")
    end,
    opts(noremap, silent, "toggle dcument diagnostics"),
  },
  {
    "<leader>xq",
    function()
      require("trouble").toggle("quickfix")
    end,
    opts(noremap, silent, "toggle quickfix"),
  },
  {
    "<leader>xl",
    function()
      require("trouble").toggle("loclist")
    end,
    opts(noremap, silent, "toggle loclist"),
  },
  {
    "gR",
    function()
      require("trouble").toggle("lsp_references")
    end,
    opts(noremap, silent, "toggle lsp references"),
  },
})

-------------------------------------- Plugin: Diffview ------------------------------------
nmap({
  { "<leader>db", cmd("DiffviewFileHistory"), opts(noremap, silent, "diff view current branch") },
  { "<leader>df", cmd("DiffviewFileHistory %"), opts(noremap, silent, "diff view current file") },
})

-------------------------------------- Notes ----------------------------------------------
local notes = require("modules.notes.config")
nmap({
  { "<leader>nn", notes.open_today, opts(noremap, silent, "Open today's note") },
  { "<leader>n[", notes.open_prev, opts(noremap, silent, "Open previous note") },
  { "<leader>n]", notes.open_next, opts(noremap, silent, "Open next note") },
  { "<leader>nw", notes.grep_notes, opts(noremap, silent, "Grep notes") },
  { "<leader>nf", notes.find_notes, opts(noremap, silent, "Find notes") },
})
