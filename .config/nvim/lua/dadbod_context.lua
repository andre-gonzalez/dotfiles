-- Context-aware SQL completion wrapper around vim-dadbod-completion.
--
-- vim-dadbod-completion's built-in nvim-cmp source returns all item kinds
-- (tables, schemas, columns, keywords) everywhere. This source wraps it and
-- filters by kind based on which SQL clause the cursor is in.
--
-- Kind codes from vim-dadbod-completion:
--   T = table,  S = schema,  C = column,  A = alias,  F = function,  R = reserved word

local M = {}

-- SQL clause → item-kind filter map.
-- "dot" means the cursor follows "word." — dadbod already returns the right
-- items for that context, so we pass everything through.
local CONTEXT_KINDS = {
  table  = { T = true, S = true },
  column = { C = true, A = true, F = true, R = true },
  dot    = nil,  -- nil means: keep all
  any    = nil,
}

-- Keywords whose presence (as the last clause keyword before the cursor)
-- establishes a SQL context.
local TABLE_KEYWORDS  = { "FROM", "JOIN", "INTO", "UPDATE", "TABLE" }
local COLUMN_KEYWORDS = { "SELECT", "WHERE", "HAVING", "ON", "SET", "BY", "WHEN", "THEN", "ELSE" }

-- Returns the position (1-based) immediately after the last whole-word
-- occurrence of `kw` in `upper_text`, or nil if not found.
local function last_keyword_pos(upper_text, kw)
  -- `.*` is greedy, so this matches the last occurrence.
  -- `%f[%a]` / `%f[%A]` are word-boundary frontier patterns.
  return upper_text:match(".*%f[%a]" .. kw .. "%f[%A]()")
end

-- Determine completion context from the SQL text of the current statement
-- up to the cursor. Returns "dot", "table", "column", or "any".
local function get_context(text)
  -- Dot-prefix: user typed "word." — dadbod handles this natively.
  if text:match("[%w_]+%.$") then return "dot" end

  local upper = text:upper()
  local last_pos = 0
  local ctx = "any"

  for _, kw in ipairs(TABLE_KEYWORDS) do
    local pos = last_keyword_pos(upper, kw)
    if pos and pos > last_pos then
      last_pos = pos
      ctx = "table"
    end
  end

  for _, kw in ipairs(COLUMN_KEYWORDS) do
    local pos = last_keyword_pos(upper, kw)
    if pos and pos > last_pos then
      last_pos = pos
      ctx = "column"
    end
  end

  return ctx
end

-- Collect the SQL statement text from statement start up to the cursor,
-- looking back up to `lookback` lines for a semicolon boundary.
local function get_statement_to_cursor(bufnr, row, col, lookback)
  lookback = lookback or 10
  local start_row = math.max(0, row - lookback)
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, row + 1, false)

  -- Trim the last line (current line) to the cursor column.
  if #lines > 0 then
    lines[#lines] = lines[#lines]:sub(1, col)
  end

  -- Walk backwards to find the last semicolon (statement boundary).
  local result = {}
  for i = #lines, 1, -1 do
    local line = lines[i]
    -- Find position after the last ";" on this line.
    local after_semi = line:match(".*;()")
    if after_semi then
      table.insert(result, 1, line:sub(after_semi))
      break
    end
    table.insert(result, 1, line)
  end

  return table.concat(result, " ")
end

-- nvim-cmp source ---------------------------------------------------------

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

function source:get_debug_name()
  return "dadbod-context"
end

function source:is_available()
  local ft = vim.bo.filetype
  return ft == "sql" or ft == "mysql" or ft == "plsql"
end

function source:get_trigger_characters()
  return { ".", '"', "`", "[", "]" }
end

local kind_map = { F = 3, C = 5, A = 6, T = 7, R = 14, S = 19 }

function source:complete(params, callback)
  local input = string.sub(params.context.cursor_before_line, params.offset)
  local raw = vim.fn["vim_dadbod_completion#omni"](0, input)
  if type(raw) ~= "table" then
    callback({ items = {}, isIncomplete = true })
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)  -- { row (1-indexed), col (0-indexed) }
  local stmt   = get_statement_to_cursor(params.context.bufnr, cursor[1] - 1, cursor[2])
  local ctx    = get_context(stmt)
  local allowed = CONTEXT_KINDS[ctx]  -- nil means allow everything

  local items = {}
  for _, item in ipairs(raw) do
    if allowed == nil or allowed[item.kind] then
      table.insert(items, {
        label       = item.abbr,
        dup         = 0,
        insertText  = item.word,
        labelDetails = { description = item.menu },
        documentation = item.info,
        kind        = kind_map[item.kind],
      })
    end
  end

  callback({ items = items, isIncomplete = true })
end

M.source = source
return M
