local keymap = require("core.keymap")
local nmap, imap, cmap, vmap, xmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.vmap, keymap.xmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Leader Key
vim.g.mapleader = " "
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

local function move_down()
  return vim.v.count > 0 and "j" or "gj"
end

local function move_up()
  return vim.v.count > 0 and "k" or "gk"
end

-- Basic
nmap({
  { "<Esc>", ":noh <CR>", opts(noremap, silent, "Clear highlights") },
  { "<C-h>", "<C-w>h", opts(noremap, "Move Left") },
  { "<C-l>", "<C-w>l", opts(noremap, "Move right") },
  { "<C-j>", "<C-w>j", opts(noremap, "Move down") },
  { "<C-k>", "<C-w>k", opts(noremap, "Move up") },
  { "<leader>w", cmd("w"), opts(noremap, "Save file") },
  { "<leader>W", cmd("w!"), opts(noremap, "Save file forcibly") },
  { "<leader>q", cmd("q"), opts(noremap, "quit neovim") },
  { "<leader>Q", cmd("qa"), opts(noremap, "quit all") },
  { "<leader>ln", cmd("set nu!"), opts(noremap, silent, "Toggle line number") },
  { "<leader>lr", cmd("set rnu!"), opts(noremap, silent, "Toggle relative number") },
  { "j", move_down(), opts(noremap, expr, "Move down") },
  { "k", move_up(), opts(noremap, expr, "Move up") },
  { "<Down>", move_down(), opts(noremap, expr, "Move down") },
  { "<Up>", move_up(), opts(noremap, expr, "Move up") },
  { "<Tab>", cmd("bnext"), opts(noremap, silent, "Goto next buffer") },
  { "<S-Tab>", cmd("bprev"), opts(noremap, silent, "Goto prev buffer") },
  { "<leader>x", cmd("bdelete"), opts(noremap, silent, "Close buffer") },
  { "<leader>b", cmd("enew"), opts(noremap, silent, "New buffer") },
  { "[q", cmd("cprevious"), opts(noremap, silent, "previous quickfix") },
  { "]q", cmd("cnext"), opts(noremap, silent, "next quickfix") },
  { "[Q", cmd("cfirst"), opts(noremap, silent, "first quickfix") },
  { "]Q", cmd("clast"), opts(noremap, silent, "last quickfix") },
})

vmap({
  { "j", move_down(), opts(noremap, expr, "Move down") },
  { "k", move_up(), opts(noremap, expr, "Move up") },
  { "<Down>", move_down(), opts(noremap, expr, "Move down") },
  { "<Up>", move_up(), opts(noremap, expr, "Move up") },
})

-- Comment
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

-- Telescope
local ivy = require("telescope.themes").get_ivy

local function get_search_text()
  if vim.v.hlsearch == 1 then
    return vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", "")
  end
  return ""
end

nmap({
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files(ivy({ hidden = true }))
    end,
    opts(noremap, silent, "Find files"),
  },
  {
    "<leader>faf",
    function()
      require("telescope.builtin").find_files(
        ivy({ follow = true, no_ignore = true, hidden = true, default_text = get_search_text() })
      )
    end,
    opts(noremap, silent, "Find all files"),
  },
  {
    "<leader>fw",
    function()
      require("telescope.builtin").live_grep(ivy({
        default_text = get_search_text(),
        additional_args = { "--hidden" },
      }))
    end,
    opts(noremap, silent, "Live grep"),
  },
  {
    "<leader>faw",
    function()
      require("telescope.builtin").live_grep(ivy({
        default_text = get_search_text(),
        additional_args = { "--hidden", "--no-ignore" },
      }))
    end,
    opts(noremap, silent, "Live grep all"),
  },
  {
    "<leader>fb",
    function()
      require("telescope.builtin").buffers(ivy())
    end,
    opts(noremap, silent, "Find buffers"),
  },
  {
    "<leader>fh",
    function()
      require("telescope.builtin").help_tags(ivy())
    end,
    opts(noremap, silent, "Help page"),
  },
  {
    "<leader>f/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(ivy())
    end,
    opts(noremap, silent, "Fuzzy find in buffer"),
  },
  {
    "<leader>fy",
    function()
      require("telescope").extensions.neoclip.default(ivy())
    end,
    opts(noremap, silent, "Yank history"),
  },
  {
    "<leader>fq",
    function()
      require("telescope.builtin").quickfix(ivy())
    end,
    opts(noremap, silent, "Filter quickfix"),
  },
})

-- oil.nvim
nmap({
  { "<leader>e", cmd("Oil"), opts(noremap, silent, "open file explorer") },
})

-- FTerm
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

-- LSP
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

-- Trouble
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

-- Diffview
nmap({
  { "<leader>gd", cmd("DiffviewOpen"), opts(noremap, silent, "Diff working tree") },
  { "<leader>gm", cmd("DiffviewOpen main..HEAD"), opts(noremap, silent, "Diff main..HEAD") },
  { "<leader>gh", cmd("DiffviewFileHistory"), opts(noremap, silent, "Git history") },
  { "<leader>gf", cmd("DiffviewFileHistory %"), opts(noremap, silent, "Git file history") },
})

-- Notes
local notes = require("modules.notes.config")
nmap({
  { "<leader>nn", notes.open_today, opts(noremap, silent, "Open today's note") },
  { "<leader>n[", notes.open_prev, opts(noremap, silent, "Open previous note") },
  { "<leader>n]", notes.open_next, opts(noremap, silent, "Open next note") },
  { "<leader>nw", notes.grep_notes, opts(noremap, silent, "Grep notes") },
  { "<leader>nf", notes.find_notes, opts(noremap, silent, "Find notes") },
  { "<leader>nt", notes.grep_todos, opts(noremap, silent, "Find TODOs") },
  { "<leader>nc", notes.toggle_checkbox, opts(noremap, silent, "Toggle checkbox") },
  { "<leader>ns", notes.sync, opts(noremap, silent, "Sync notes to git") },
})

-- Yank with Path
local editor_config = require("modules.editor.config")

vmap({
  {
    "<leader>yr",
    ":<C-u>lua require('modules.editor.config').yank_with_path(false)<CR>",
    opts(noremap, silent, "Yank with relative path"),
  },
  {
    "<leader>ya",
    ":<C-u>lua require('modules.editor.config').yank_with_path(true)<CR>",
    opts(noremap, silent, "Yank with absolute path"),
  },
})
