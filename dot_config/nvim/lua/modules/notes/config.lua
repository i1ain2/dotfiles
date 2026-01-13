local M = {}

M.opts = {
  notes_dir = vim.fn.expand("~/src/github.com/i1ain2/notes/notes"),
  date_format = "%Y%m%d",
  extension = ".md",
}

function M.get_sorted_notes()
  local pattern = M.opts.notes_dir .. "/*" .. M.opts.extension
  local files = vim.fn.glob(pattern, false, true)
  table.sort(files)
  return files
end

function M.open_today()
  local filename = os.date(M.opts.date_format) .. M.opts.extension
  local filepath = M.opts.notes_dir .. "/" .. filename

  vim.fn.mkdir(M.opts.notes_dir, "p")
  vim.cmd("edit " .. filepath)
end

function M.open_adjacent(direction)
  local files = M.get_sorted_notes()
  if #files == 0 then
    vim.notify("メモファイルがありません", vim.log.levels.WARN)
    return
  end

  local current = vim.fn.expand("%:p")
  local current_idx = nil

  for i, file in ipairs(files) do
    if file == current then
      current_idx = i
      break
    end
  end

  if current_idx == nil then
    vim.cmd("edit " .. files[#files])
    return
  end

  local target_idx = current_idx + direction
  if target_idx < 1 then
    vim.notify("これが最初のメモです", vim.log.levels.INFO)
    return
  elseif target_idx > #files then
    vim.notify("これが最新のメモです", vim.log.levels.INFO)
    return
  end

  vim.cmd("edit " .. files[target_idx])
end

function M.open_prev()
  M.open_adjacent(-1)
end

function M.open_next()
  M.open_adjacent(1)
end

function M.grep_notes()
  require("telescope.builtin").live_grep({
    cwd = M.opts.notes_dir,
    prompt_title = "Grep Notes",
  })
end

function M.find_notes()
  require("telescope.builtin").find_files({
    cwd = M.opts.notes_dir,
    prompt_title = "Find Notes",
  })
end

function M.setup()
  -- Register user commands for optional use
  vim.api.nvim_create_user_command("NotesToday", M.open_today, {})
  vim.api.nvim_create_user_command("NotesPrev", M.open_prev, {})
  vim.api.nvim_create_user_command("NotesNext", M.open_next, {})
  vim.api.nvim_create_user_command("NotesGrep", M.grep_notes, {})
  vim.api.nvim_create_user_command("NotesFind", M.find_notes, {})
end

return M
