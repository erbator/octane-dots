-- Syntax highlighting / indentation via tree-sitter.
--
-- nvim-treesitter `main` (the old `master` branch is frozen and breaks on
-- Neovim >= 0.12 with "attempt to call method 'range'"). `main` only manages
-- parsers + queries; highlighting/indent are switched on per buffer below.
-- :TSInstall <lang> / :TSUpdate / :TSLog — needs tree-sitter-cli, a C compiler,
-- tar and curl (all in setup/arch.sh).

local languages = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'astro',
  'sql',
  'go',
  'xml',
  'json',
  'yaml',
  'toml',
  'css',
  'javascript',
  'typescript',
  'tsx',
  'python',
  'rust',
  'elixir',
  'regex',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'

      -- install anything from the list that is missing (async, quiet)
      local installed = {}
      for _, lang in ipairs(ts.get_installed 'parsers') do
        installed[lang] = true
      end
      local missing = vim.tbl_filter(function(l)
        return not installed[l]
      end, languages)
      if #missing > 0 then
        ts.install(missing, { summary = true })
      end

      -- per buffer: start highlighting + tree-sitter indent when a parser exists;
      -- auto-install parsers from the list on first use of that filetype
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          -- language.add() returns nil (no throw) when there is no parser, e.g. neo-tree
          local ok, has_parser = pcall(vim.treesitter.language.add, lang)
          if not (ok and has_parser) then
            if vim.tbl_contains(languages, lang) and not installed[lang] then
              installed[lang] = true -- don't retry on every buffer
              ts.install({ lang }, { summary = true })
            end
            return
          end
          if pcall(vim.treesitter.start, args.buf, lang) and ft ~= 'ruby' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
