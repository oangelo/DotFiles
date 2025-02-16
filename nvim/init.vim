" ============================
" Configuração Inicial do nvim
" ============================

" Define o diretório de configuração
let s:VIMROOT = $HOME . "/.config/nvim"

" Cria os diretórios necessários, se ainda não existirem
if exists("*mkdir")
  silent! call mkdir(s:VIMROOT, "p")
  silent! call mkdir(s:VIMROOT . "/bundle", "p")
else
  echo "Error: Não foi possível criar os diretórios."
  exit
endif

" -------------------------------
" Configuração do Gerenciador de Plugins (vim-plug)
" -------------------------------
if glob(s:VIMROOT . "/bundle/") != ""
  " Se o vim-plug ainda não estiver instalado...
  if glob(s:VIMROOT . "/bundle/vim-plug/") == ""
    if (match(system('which git'), "git not found") == -1)
      echo "Configurando o gerenciador de plugins..."
      silent! execute "cd " . s:VIMROOT . "/bundle/"
      silent! execute "!echo && git clone https://github.com/junegunn/vim-plug.git"
      if glob(s:VIMROOT . "/bundle/vim-plug/") == ""
        echo "Erro: Não foi possível configurar o plugin manager. Tente novamente ou instale manualmente."
      endif
    else
      echo "Dica: Instale o Git e reinicie o Vim para gerenciar os plugins. Veja https://github.com/junegunn/vim-plug"
    endif
  endif
  if glob(s:VIMROOT . "/bundle/vim-plug/") != ""
    if has('vim_starting')
      let &runtimepath = s:VIMROOT . "/bundle/vim-plug," . &runtimepath
      runtime plug.vim
    endif
    call plug#begin()
      " Plugins já existentes
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      Plug 'Yggdroot/indentLine'
      Plug 'ap/vim-css-color'
      Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
      " Novos plugins para melhorar a edição de HTML:
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      Plug 'windwp/nvim-ts-autotag'
      Plug 'andymass/vim-matchup'
      Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
    call plug#end()
  endif
endif

" -------------------------------
" Configurações Gerais
" -------------------------------
set shiftwidth=2        " número de espaços para indentação
set tabstop=2           " número de espaços que um tab representa
set expandtab           " converte tabs em espaços
set autoindent          " mantém a indentação da linha anterior
set clipboard+=unnamedplus  " usar o clipboard do sistema (permite copiar e colar entre nvim e o SO)
set cursorline

" Exibir números de linha e números relativos (ajuda na navegação)
set number

" Ativar suporte ao mouse em todos os modos
set mouse=a

" Usar cores verdadeiras (se seu terminal suportar)
set termguicolors

" Mostrar sempre a coluna de sinais (útil para plugins de linting, git, etc.)
set signcolumn=yes

" Dividir janelas novas para a direita e abaixo (split behavior)
set splitright
set splitbelow

" Busca: ignorecase (mas se usar maiúsculas, diferencia) e realce de resultados
set ignorecase
set smartcase
set incsearch
set hlsearch

" Ativar o corretor ortográfico
set spell

" Definir as línguas para pt-br e en-us
set spelllang=pt_br,en_us

" (Opcional) Mapeamentos para navegar entre os erros de ortografia:
" "]s" vai para o próximo erro e "[s" para o erro anterior (esses comandos já vêm por padrão)

" Salta para a última posição editada ao reabrir um arquivo
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" | endif
endif

" Tempo de atualização (updatetime) menor para respostas mais rápidas (útil para plugins, por exemplo, o coc.nvim)
set updatetime=300

" Ativar undo persistente (salva histórico mesmo entre sessões)
set undofile
" Defina um diretório para o undo (garanta que o diretório exista)
if !isdirectory(expand("~/.config/nvim/undo"))
  call mkdir(expand("~/.config/nvim/undo"), "p")
endif
set undodir=~/.config/nvim/undo//


" Mapeamento: K para mostrar documentação (usando o coc.nvim para outras linguagens)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if index(['vim', 'help'], &filetype) >= 0
    execute 'help ' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Definir folding para HTML com base no tree‐sitter
autocmd FileType html setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevelstart=2
autocmd BufWinEnter *.html setlocal foldlevel=2


" -------------------------------
" Configuração do nvim-treesitter e nvim-ts-autotag via Lua
" -------------------------------
" Se estiver usando Neovim 0.5+ (e possivelmente com suporte a Lua), você pode configurar o tree-sitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
}
EOF

" -------------------------------
" Outras Sugestões e Plugins
" -------------------------------
" O plugin vim-matchup (instalado acima) já melhora o realce de correspondência de tags.
" Se desejar ajustar alguma configuração específica, consulte :help matchup.
" O plugin indentLine já estará ativo para mostrar as linhas verticais de indentação;
" para personalizar cores, por exemplo, você pode adicionar:
let g:indentLine_setColors = 0
highlight IndentLine guifg=#A4E57E ctermfg=239


nnoremap <leader>p :Prettier<CR>

" -------------------------------
" Fim da Configuração
" -------------------------------

" Agora, ao editar arquivos HTML:
" - As tags serão automaticamente "foldadas" conforme a estrutura (você pode usar zc, zo, za para manipular os folds).
" - O nvim-ts-autotag fechará automaticamente as tags abertas.
" - O vim-matchup facilitará a visualização das tags correspondentes.
" - O indentLine mostrará as linhas verticais que ajudam a visualizar a indentação.
" - O clipboard do sistema já está integrado para copiar/colar diretamente.

