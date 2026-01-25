local M = {}

local notes_root = vim.env.NOTES_ROOT

M.opts = {
  notes_root = notes_root,
  daily_note_dir = notes_root and (notes_root .. "/notes") or nil,
  date_format = "%Y%m%d",
  extension = ".md",
}

local function require_notes_root()
  if not notes_root then
    error("NOTES_ROOT environment variable is not set")
  end
end

function M.get_sorted_notes()
  require_notes_root()
  local pattern = M.opts.daily_note_dir .. "/*" .. M.opts.extension
  local files = vim.fn.glob(pattern, false, true)
  table.sort(files)
  return files
end

function M.open_today()
  require_notes_root()
  local filename = os.date(M.opts.date_format) .. M.opts.extension
  local filepath = M.opts.daily_note_dir .. "/" .. filename

  vim.fn.mkdir(M.opts.daily_note_dir, "p")
  vim.cmd("edit " .. filepath)
end

function M.open_adjacent(direction)
  local files = M.get_sorted_notes()
  if #files == 0 then
    vim.notify("ノートファイルがありません", vim.log.levels.WARN)
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
    vim.notify("これが最初のノートです", vim.log.levels.INFO)
    return
  elseif target_idx > #files then
    vim.notify("これが最新のノートです", vim.log.levels.INFO)
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
  require_notes_root()
  require("telescope.builtin").live_grep({
    cwd = M.opts.notes_root,
    prompt_title = "Grep Notes",
  })
end

function M.find_notes()
  require_notes_root()
  require("telescope.builtin").find_files({
    cwd = M.opts.notes_root,
    prompt_title = "Find Notes",
  })
end

function M.grep_todos()
  require_notes_root()
  require("telescope.builtin").live_grep({
    cwd = M.opts.daily_note_dir,
    default_text = "- \\[ \\]",
    prompt_title = "Find TODOs",
  })
end

function M.toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  local new_line

  if line:match("%- %[ %]") then
    new_line = line:gsub("%- %[ %]", "- [x]", 1)
  elseif line:match("%- %[x%]") then
    new_line = line:gsub("%- %[x%]", "- [ ]", 1)
  elseif line:match("%- %[X%]") then
    new_line = line:gsub("%- %[X%]", "- [ ]", 1)
  else
    return
  end

  vim.api.nvim_set_current_line(new_line)
end

function M.sync()
  require_notes_root()
  local notes_root = M.opts.notes_root
  local cmd = string.format(
    "cd %s && git pull && git add -A && git commit -m 'sync notes'; git push",
    vim.fn.shellescape(notes_root)
  )

  -- 開始通知（IDを保存して後で更新）
  vim.notify("ノート同期中...", vim.log.levels.INFO, {
    title = "Notes",
  })

  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("ノート同期完了", vim.log.levels.INFO, {
          title = "Notes",
        })
      else
        vim.notify("ノート同期失敗", vim.log.levels.ERROR, {
          title = "Notes",
          timeout = false,
        })
      end
    end,
  })
end

function M.setup()
  -- Register user commands for optional use
  vim.api.nvim_create_user_command("NotesToday", M.open_today, {})
  vim.api.nvim_create_user_command("NotesPrev", M.open_prev, {})
  vim.api.nvim_create_user_command("NotesNext", M.open_next, {})
  vim.api.nvim_create_user_command("NotesGrep", M.grep_notes, {})
  vim.api.nvim_create_user_command("NotesFind", M.find_notes, {})
  vim.api.nvim_create_user_command("NotesTodo", M.grep_todos, {})
  vim.api.nvim_create_user_command("NotesSync", M.sync, {})
end

return M
