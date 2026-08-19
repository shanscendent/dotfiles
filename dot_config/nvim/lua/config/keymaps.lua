-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nom-http conveniences
local function auto_fix_json_syntax(lines)
  local cleaned = {}
  for _, line in ipairs(lines) do
    local trimmed = line:gsub("%s+$", "")
    if #trimmed > 0 then
      table.insert(cleaned, trimmed)
    end
  end

  -- Strip existing trailing commas from line ends
  for i, line in ipairs(cleaned) do
    cleaned[i] = line:gsub(",$", "")
  end

  -- Re-insert commas only where needed between sibling elements
  for i = 1, #cleaned - 1 do
    local current = cleaned[i]
    local next_line = cleaned[i + 1]

    local ends_with_open = current:match("[%{%[]%s*$")
    local next_starts_with_close = next_line:match("^%s*[%}%]]")

    if not ends_with_open and not next_starts_with_close then
      cleaned[i] = current .. ","
    end
  end

  local result = table.concat(cleaned, "\n")
  -- Fix intra-line trailing commas before closing braces (e.g., {"a": 1,})
  return (result:gsub(",(%s*[%}%]])", "%1"))
end

local function edit_cli_json_line()
  if vim.fn.executable("jq") == 0 then
    vim.notify("`jq` binary not found in Neovim's PATH!", vim.log.levels.ERROR)
    return
  end

  local parent_buf = vim.api.nvim_get_current_buf()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local line_text = vim.api.nvim_get_current_line()

  local prefix, json_str = line_text:match("^(%s*%a+%s+%S+%s+)(.*)$")
  if not prefix or not json_str then
    vim.notify("Line doesn't match 'METHOD /url {...}' format", vim.log.levels.WARN)
    return
  end

  local formatted_lines = vim.fn.systemlist({ "jq", "." }, json_str)
  if vim.v.shell_error ~= 0 or #formatted_lines == 0 then
    formatted_lines = { json_str }
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.min(80, vim.o.columns - 10)
  local height = math.min(18, vim.o.lines - 10)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " Edit JSON Payload ",
    title_pos = "center",
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted_lines)
  vim.bo[buf].filetype = "json"

  vim.keymap.set("n", "<leader>w", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- Auto-repair broken comma locations before sending to jq
    local sanitized_json = auto_fix_json_syntax(lines)
    local minified_output = vim.fn.systemlist({ "jq", "-c", "." }, sanitized_json)

    if vim.v.shell_error == 0 and #minified_output > 0 then
      local result_line = prefix .. minified_output[1]
      vim.api.nvim_buf_set_lines(parent_buf, cursor_line - 1, cursor_line, false, { result_line })
      vim.api.nvim_win_close(win, true)
    else
      vim.notify("Invalid JSON syntax! (Check quotes or colons)", vim.log.levels.ERROR)
    end
  end, { buffer = buf, desc = "Save compacted CLI payload line" })
end

vim.keymap.set("n", "<leader>cj", edit_cli_json_line, { desc = "Edit CLI JSON payload in float" })
