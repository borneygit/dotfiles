-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

-- LSP progress bar {{{
function _G.lsp_progress() ---- 0.9 version
  local lsp_clients = vim.lsp.get_active_clients()
  local lsp_client_names = {}
  for _, client in pairs(lsp_clients) do
    table.insert(lsp_client_names, client.id .. ':' .. client.name)
  end
  local lsp_msg = vim.lsp.util.get_progress_messages()[1]
  if lsp_msg then
    local name = lsp_msg.name or ''
    local msg = lsp_msg.message or ''
    local percentage = lsp_msg.percentage or 0
    local title = lsp_msg.title or ''
    return string.format(' %%<%s: %s %s (%s%%%%) ', name, title, msg, percentage)
  elseif #lsp_clients > 0 then
    return table.concat(lsp_client_names, ' ')
  else
    return 'NO LSP'
  end
end

-- neovim 0.10 version, since this version get_active_clients and get_progress_messages no longer work.
function lsp_progress_v010()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return 'NO LSP'
  end
  local messages = {}
  -- format client lsp progress from each client.progress ringbuffer.
  -- example: 1:clangd(indexing 90%)
  -- modified from vim.lsp.status() function's source code.
  for _, c in ipairs(clients) do
    -- defaults example: '1:clangd'
    local message = c.id .. ':' .. c.name
    local percentage = nil
    local title = nil
    for progress in c.progress do
      local value = progress.value
      if type(value) == 'table' and value.kind and value.title and value.percentage then
        percentage = math.max(percentage or 0, value.percentage)
        title = value.title
      end
    end
    if percentage and title then
      local status = title .. ' ' .. tostring(percentage) .. '%%'
      message = message .. ' (' .. status .. ')'
    end
    messages[#messages + 1] = message
  end
  return table.concat(messages, ' ')
end

-- lsp_progress for neovim 0.10
if vim.version().minor > 9 then
  _G.lsp_progress = lsp_progress_v010
end
-- }}}

-- Plugin lualine {{{
require('lualine').setup({
  options = {
    theme = 'onedark',
    icons_enabled = false,
    section_separators = '',
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_b = {
      'filename',
      {
        'diagnostics',
        -- Show diagnostics even if there are none.
        always_visible = true,
      },
      {
        'lsp_progress()',
        color = 'Debug',
      },
    },
    lualine_x = {
      'diff',
      'branch',
      'encoding',
      'fileformat',
      'filetype',
    },
  },
  -- Having a single statusline instead of each for every window.
  globalstatus = true,
})
-- }}}
