-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

-- Binary-Search style cursor skip
-- 's' to skip forward inline to half of remaining to end.
-- 'S' to skip backward inline to half of remaining to head.
-- 'ctrl-s' to skip forward vertically to half of remaining to the last line.
-- 'ctrl-shift-s' (acutally esc-s) to skip backward vertically to half of remaining to the first line.

-- Note: The following code is written with the help of gpt ai tool.

local function skip_inline_forward()
  local cur_pos = vim.fn.getpos('.')
  local line = vim.fn.getline('.')
  local cur_col = cur_pos[3]
  local remaining_len = #line - cur_col
  if remaining_len <= 0 or vim.fn.col('.') >= vim.fn.col('$') - 3 then
    -- Move to next line if already at line's end
    -- why -3? to compat with chinese char.
    if cur_pos[2] < vim.fn.line('$') then
      vim.fn.setpos('.', { cur_pos[1], cur_pos[2] + 1, 1, cur_pos[4] })
    end
  else
    local half_len = cur_col + (remaining_len / 2)
    half_len = math.floor(half_len + 0.5)
    vim.fn.setpos('.', { cur_pos[1], cur_pos[2], half_len, cur_pos[4] })
  end
end

local function skip_inline_backward()
  local cur_pos = vim.fn.getpos('.')
  local line = vim.fn.getline('.')
  local cur_col = cur_pos[3]
  if cur_col <= 1 then
    -- Move to previous line if already at line's head.
    if cur_pos[2] > 1 then
      vim.fn.setpos('.', { cur_pos[1], cur_pos[2] - 1, #vim.fn.getline(cur_pos[2] - 1), cur_pos[4] })
    end
  else
    local half_len = cur_col / 2
    half_len = math.floor(half_len + 0.5)
    vim.fn.setpos('.', { cur_pos[1], cur_pos[2], half_len, cur_pos[4] })
  end
end

local function skip_vertical_forward()
  local cur_pos = vim.fn.getpos('.')
  local total_lines = vim.fn.line('$')
  local cur_line = cur_pos[2]
  local remaining_lines = total_lines - cur_line
  local half_line = cur_line + math.floor(remaining_lines / 2)
  vim.fn.setpos('.', { cur_pos[1], half_line, cur_pos[3], cur_pos[4] })
end

local function skip_vertical_backward()
  local cur_pos = vim.fn.getpos('.')
  local cur_line = cur_pos[2]
  local half_line = math.floor(cur_line / 2)
  vim.fn.setpos('.', { cur_pos[1], half_line, cur_pos[3], cur_pos[4] })
end

vim.keymap.set('n', '<C-s>', function()
  skip_vertical_forward()
end, { noremap = true, silent = true })
-- Note: we may need to remap `Ctrl-Shift-S` to `esc-s` for the terminal emulater.
vim.keymap.set('n', '<esc>s', function()
  skip_vertical_backward()
end, { noremap = true, silent = true })
vim.keymap.set('n', 's', function()
  skip_inline_forward()
end, { noremap = true, silent = true })
vim.keymap.set('n', 'S', function()
  skip_inline_backward()
end, { noremap = true, silent = true })
