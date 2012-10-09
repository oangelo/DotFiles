" basics
set t_Co=256            " set 256 color
set nocompatible        " use Vim defaults
set mouse=a             " make sure mouse is used in all cases.
colorscheme lucius     " define syntax color scheme
set shortmess+=I        " disable the welcome screen
set complete+=k         " enable dictionary completion
set completeopt+=longest
set clipboard+=unnamed  " yank and copy to X clipboard
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set showmode            " show mode at bottom of screen
set ww=<,>,[,]          " whichwrap -- left/right keys can traverse up/down
set cmdheight=2         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=5               " show matching brackets for 0.5 seconds
set laststatus=2

" wrap like other editors
set wrap                " word wrap
set textwidth=80        " 
"set lbr                 " line break
"set display=lastline    " don't display @ with long paragraphs

" backup settings
set backup              " keep a backup file
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

" tabs and indenting
set expandtab           " insert spaces instead of tab chars
set tabstop=4           " a n-space tab width
set shiftwidth=4        " allows the use of < and > for VISUAL indenting
set softtabstop=4       " counts n spaces when DELETE or BCKSPCE is used
set autoindent          " auto indents next new line
set number

" searching
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search

" syntax highlighting
syntax on               " enable syntax highlighting

" plug-in settings
filetype plugin on
filetype indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let mapleader = ","
map <f2> :w<cr><leader>ll
" map : to ; in normal mode
map ; :
" single character insert
nmap <Space> i<Space><Esc>
" spell check
map <F12> :w<CR>:!aspell -c %<CR><CR>:e<CR><CR> 
"latex suite
let g:Tex_DefaultTargetFormat = "pdf" 
"status line
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

"Make Vim restore cursor position in files
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

"add gates to .h files, important to prevent multiple inclusions
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

function! GetProtoLine()
  let ret       = ""
  let line_save = line(".")
  let col_save  = col(".")
  let top       = line_save - winline() + 1
  let so_save = &so
  let &so = 0
  let istypedef = 0
  " find closing brace
  let closing_lnum = search('^}','cW')
  if closing_lnum > 0
    if getline(line(".")) =~ '\w\s*;\s*$'
      let istypedef = 1
      let closingline = getline(".")
    endif
    " go to the opening brace
    normal! %
    " if the start position is between the two braces
    if line(".") <= line_save
      if istypedef
        let ret = matchstr(closingline, '\w\+\s*;')
      else
        " find a line contains function name
        let lnum = search('^\w','bcnW')
        if lnum > 0
          let ret = getline(lnum)
        endif
      endif
    endif
  endif
  " restore position and screen line
  exe "normal! " . top . "Gz\<CR>"
  call cursor(line_save, col_save)
  let &so = so_save
  return ret
endfunction

function! WhatFunction()
  if &ft != "c" && &ft != "cpp"
    return ""
  endif
  let proto = GetProtoLine()
  if proto == ""
    return "?"
  endif
  if stridx(proto, '(') > 0
    let ret = matchstr(proto, '\w\+(\@=')
  elseif proto =~# '\<struct\>'
    let ret = matchstr(proto, 'struct\s\+\w\+')
  elseif proto =~# '\<class\>'
    let ret = matchstr(proto, 'class\s\+\w\+')
  else
    let ret = strpart(proto, 0, 15) . "..."
  endif
  return ret
endfunction

" You may want to call WhatFunction in the statusline
set statusline=%f:%{WhatFunction()}\ %m%=\ %l-%v\ %p%%\ %02B

"code completion fot cpp
set completeopt=longest,menuone  
" Limit popup menu height
"set pumheight = 15
"let g:clang_snippets = 1
"let g:clang_snippets_engine = 'clang_complete'
let g:clang_complete_copen = 1
let g:clang_use_library=1
"let g:clang_user_options = '-std=c++11'
 " SuperTab option for context aware completion
 let g:SuperTabDefaultCompletionType = "context"
map :w:!latex % && clear
