let s:VIMROOT = $HOME."/.config/nvim"

" Create necessary folders if they don't already exist.
if exists("*mkdir")
    silent! call mkdir(s:VIMROOT, "p")
    silent! call mkdir(s:VIMROOT."/bundle", "p")
else
    echo "Error: Create the directories "
    exit
endif

" if the ".s:VIMROOT."/bundle/ directory exists.
if glob(s:VIMROOT."/bundle/") != ""
  if glob(s:VIMROOT."/bundle/vim-plug/") == "" " if Plug doesn't exist
    if (match(system('which git'), "git not found") == -1) " if git is installed
      echo "Setting up plugin manager..."
      silent! execute "cd ".s:VIMROOT."/bundle/"
      silent! execute "!echo && git clone https://github.com/junegunn/vim-plug.git"
      if glob(s:VIMROOT."/bundle/vim-plug/") == "" " if Plug still doesn't exist
        echo "Error: Unable to set up the plugin manager. Something went wrong (maybe git failed or a connection problem). Restart Vim to try again or clone https://github.com/junegunn/vim-plug.git into ~/.vim/bundle manually."
      endif
    else
      echo "Tip: Install Git then restart Vim for plugin management. See Plug for details: https://github.com/junegunn/vim-plug"
    endif
  endif
  if glob(s:VIMROOT."/bundle/vim-plug/") != "" " if Plug exists
    " BEGIN PLUGIN MANAGEMENT:
    if has('vim_starting')
      let &runtimepath=s:VIMROOT."/bundle/vim-plug," . &runtimepath
      runtime plug.vim
    endif
    call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'Yggdroot/indentLine'
    Plug 'ap/vim-css-color' 
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    call plug#end()
  endif
endif

set shiftwidth=2
set tabstop=2
set expandtab ts=2 sw=2 ai
set clipboard+=unnamedplus
" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


