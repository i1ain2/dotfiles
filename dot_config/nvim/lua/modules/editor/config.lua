local M = {}

--- Resolve file path from diffview buffer or normal buffer
--- @param use_absolute boolean Use absolute path if true, relative if false
--- @return string filepath
local function resolve_diffview_or_buffer_path(use_absolute)
  local bufname = vim.fn.expand("%")

  -- Handle diffview:// buffers (e.g., diffview://a/path/to/file)
  if bufname:match("^diffview://") then
    -- Extract path after diffview://[prefix]/
    local path = bufname:gsub("^diffview://[^/]*/", "")
    if use_absolute then
      return vim.fn.fnamemodify(path, ":p")
    else
      return vim.fn.fnamemodify(path, ":.")
    end
  end

  -- Normal buffer
  return use_absolute and vim.fn.expand("%:p") or vim.fn.expand("%:.")
end

--- Yank selected code with file path
--- @param use_absolute boolean Use absolute path if true, relative if false
function M.yank_with_path(use_absolute)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local filepath = resolve_diffview_or_buffer_path(use_absolute)
  local filetype = vim.bo.filetype
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local code = table.concat(lines, "\n")

  local line_info = start_line == end_line
    and string.format("L%d", start_line)
    or string.format("L%d-L%d", start_line, end_line)

  local result = string.format("%s:%s\n```%s\n%s\n```", filepath, line_info, filetype, code)
  vim.fn.setreg("+", result)
  vim.notify("Yanked with path: " .. filepath .. ":" .. line_info, vim.log.levels.INFO)
end

return M
