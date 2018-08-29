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
"set textwidth=120        " 
"set lbr                 " line break
"set display=lastline    " don't display @ with long paragraphs

" backup settings
set backup              " keep a backup file
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

" tabs and indenting
set expandtab           " insert spaces instead of tab chars
set tabstop=2           " a n-space tab width
set shiftwidth=2        " allows the use of < and > for VISUAL indenting
set softtabstop=2       " counts n spaces when DELETE or BCKSPCE is used
set autoindent          " auto indents next new line
set number

" searching
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
"set smartcase           " upper-case sensitive search

" syntax highlighting
syntax on               " enable syntax highlighting

" plug-in settings
filetype plugin on
filetype indent on
map ; :
" single character insert
nmap <Space> i<Space><Esc>

"Make Vim restore cursor position in files
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

"NERDtree
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>
map <C-t> :NERDTreeToggle<CR>
map  <C-k> :bn<CR>
map  <C-n> :tabnew<CR>
nnoremap c :bp\|bd #<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
