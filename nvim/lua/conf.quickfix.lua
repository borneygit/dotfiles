-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

-- Add Diagnostics to Quickfix Window.
-- https://github.com/neovim/nvim-lspconfig/issues/69

-- global switch:whether enable pushing diagnostics to quickfix window.
vim.g._enable_push_diagnostics_to_quickfix = false

-- Push diagnostics info to quickfix window.
local push_diagnostics_to_quickfix = function(diagnostics)
  local qflist = {}
  for bufnr, diagnostic in pairs(diagnostics) do
    for _, d in ipairs(diagnostic) do
      d.bufnr = bufnr
      d.lnum = d.range.start.line + 1
      d.col = d.range.start.character + 1
      d.text = d.message
      table.insert(qflist, d)
    end
  end
  -- setqflist to add all diagnostics to the quickfix list.
  -- setloclist to add buffer diagnostics to the location list.
  vim.diagnostic.setloclist(qflist)
end

-- Register a handler to push diagnostics to quickfix window if new diagnostics occurs.
local publish_diagnostics_method = 'textDocument/publishDiagnostics'
local default_diagnostics_handler = vim.lsp.handlers[publish_diagnostics_method]

vim.lsp.handlers[publish_diagnostics_method] = function(err, method, result, client_id, bufnr, config)
  default_diagnostics_handler(err, method, result, client_id, bufnr, config)
  if vim.g._enable_push_diagnostics_to_quickfix then
    local diagnostics = vim.diagnostic.get()
    push_diagnostics_to_quickfix(diagnostics)
  end
end

-- Disable push diagnostics to quickfix.
local disable_push_diagnostics = function()
  -- Quickfix window's id.
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  if qf_winid > 0 then
    -- Disable quickfix automatically if quickwindow is closed.
    vim.g._enable_push_diagnostics_to_quickfix = false
  end
end

-- Disable push diagnostics to quickfix if Quickfix window disapper.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(args)
    vim.api.nvim_create_autocmd('BufWinLeave', { buffer = args.buf, callback = disable_push_diagnostics })
  end,
})

-- Call :Quickfix to enter a quickfix window for all diagnostics under current buffer.
vim.api.nvim_create_user_command('Quickfix', function(opts)
  vim.g._enable_push_diagnostics_to_quickfix = true
  -- Push at once if diagnostics is not empty.
  local diagnostics = vim.diagnostic.get()
  if next(diagnostics) ~= nil then
    push_diagnostics_to_quickfix(diagnostics)
  end
end, {})
