-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
      vim.api.nvim_command 'silent update'
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    for _, client in ipairs(vim.lsp.get_clients { bufnr = 0, name = 'gopls' }) do
      local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
      params.context = { only = { 'source.organizeImports' } }
      local result = client:request_sync('textDocument/codeAction', params, 1000, 0)
      for _, r in pairs(result and result.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})
