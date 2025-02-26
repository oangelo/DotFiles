-------------------------------
-- Configurações Gerais do Neovim
-------------------------------
-- Números de linha e números relativos
vim.opt.number = true
vim.opt.relativenumber = true

-- Ativar suporte ao mouse e cores verdadeiras
vim.opt.mouse = 'a'
vim.opt.termguicolors = true

-- Manter coluna de sinais visível
vim.opt.signcolumn = 'yes'

-- Configurar splits: nova janela à direita e abaixo
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Configurações de scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Usar o clipboard do sistema
vim.opt.clipboard:append("unnamedplus")

-- Destacar a linha do cursor
vim.opt.cursorline = true

-- Configuração de folds utilizando tree-sitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Inicia com todos os folds fechados (pode ajustar conforme sua preferência)
vim.opt.foldlevelstart = 0

-- Salta para a última posição editada ao reabrir um arquivo
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_line = vim.fn.line("'\"")
    if last_line > 0 and last_line <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})


-- Inicia o bloco de plugins
vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')

  " Plugin para configuração do LSP para Python
  Plug 'neovim/nvim-lspconfig'

  " Plugin para autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'

  " Plugins para snippets (opcional)
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  " Plugin para integração de formatadores e linters
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'

  " Plugin do nvim-treesitter (para syntax, folds, etc.)
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  call plug#end()
]]
-------------------------------
-- Configuração do LSP para Python (Pyright)
-------------------------------
require('lspconfig').pyright.setup{
  -- Você pode adicionar on_attach e capabilities customizadas aqui
}

-------------------------------
-- Configuração do nvim-cmp (autocompletion)
-------------------------------
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- Expande o snippet com LuaSnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),  -- Força a exibição do menu de completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirma a sugestão selecionada
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },  -- Se estiver usando snippets
  }, {
    { name = 'buffer' },
  })
})

-------------------------------
-- Configuração do null-ls para Black e Flake8
-------------------------------
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.flake8,
  },
})

-------------------------------
-- Mapeamentos Adicionais
-------------------------------
-- Exemplo: mapeamento para formatar o arquivo atual com Black
vim.keymap.set('n', '<leader>fb', ':!black %<CR>', { noremap = true, silent = true })

-- Exemplo: mapeamento para abrir a documentação com "K"
vim.keymap.set('n', 'K', function()
  if vim.bo.filetype == "vim" or vim.bo.filetype == "help" then
    vim.cmd('help ' .. vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end, { silent = true })

-------------------------------
-- Outras Configurações (opcionais)
-------------------------------
-- Você pode adicionar aqui configurações específicas para outros plugins, treesitter, etc.
-- Exemplo: configurar o tema, statusline, file explorer, etc.
--
-- Fim do init.lua

