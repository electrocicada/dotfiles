set nocompatible

call plug#begin('~/.vim/plugged')

"=====|Basic settings|=====
nnoremap <SPACE> <Nop>
let mapleader=" "

syntax on
set number relativenumber
set t_Co=256
set t_ut = ""
set encoding=UTF-8

set termguicolors

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Better command-line completion
set wildmenu

"Tabs
set tabstop=2
set expandtab
set smarttab
set softtabstop=2
set shiftwidth=2

"Search
set hlsearch
set ignorecase
set incsearch
nnoremap <silent> <Leader>/ :nohl<CR>

"Don't make chaos on my display
"set nowrap
set backspace=indent,eol,start
set nojoinspaces
set nofoldenable

"Text wraping
set wrap 
set linebreak
set nolist

"Disable backups
set nobackup
set noswapfile

"set keymap=russian-jcukenwin
set keymap=ukrainian-jcuken
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

"Alacrittu colors patch
if &term == "alacritty"
    let &term = "xterm-256color"
endif

"Highlight insert mode
"set cursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdcommenter'
let g:NERDCustomDelimiters = { 'c': { 'left': '//' }  }


"=====|Motion and navigation|=====
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeShowHidden=1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>easymotion-prefix)

Plug 'ctrlpvim/ctrlp.vim'


function! WinMove(key) 
  let t:curwin = winnr()
  exec "wincmd " .a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

map <silent> <Leader>h : call WinMove('h')<CR>
map <silent> <Leader>j : call WinMove('j')<CR>
map <silent> <Leader>k : call WinMove('k')<CR>
map <silent> <Leader>l : call WinMove('l')<CR>

"Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Handy feature
noremap ; :

"Some scrolling features
Plug 'preservim/vim-wheel'
let g:wheel#map#up   = '<c-k>'
let g:wheel#map#down = '<c-j>'

let g:wheel#map#mouse = 1      " 1=natural, 0=disable, -1=reverse

Plug 'psliwka/vim-smoothie'



"=====|Git|=====
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'
" Use fontawesome icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = '<'

let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
"highlight SignColumn ctermbg=bg



"=====|Go|=====
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"Go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

"Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"Ex: `,b` for building, `,r` for running and `,b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

augroup completion_preview_close
  autocmd!
  autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
augroup END

autocmd FileType go nmap <leader>d  <Plug>(go-doc-browser)

"Highlight vertical line in .go')
if (&ft=='go')
  set colorcolumn=90
  highlight ColorColumn ctermbg=darkgray 
endif

"LSP
Plug 'ycm-core/YouCompleteMe'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


"=====|C++|=====
Plug 'octol/vim-cpp-enhanced-highlight'
let c_no_curly_error=1


"=====|i3config|=====
Plug 'mboughaba/i3config.vim'
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>
autocmd! bufwritepost ~/.config/i3/config :!sh -xc 'i3-msg restart'
autocmd! bufwritepost ~/.config/i3starus/config :!sh -xc 'i3-msg restart'


"=====|UML|=====
Plug 'scrooloose/vim-slumlord'


"=====|LaTeX|=====
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"let g:livepreview_previewer = 'okular'
let g:livepreview_previewer = 'zathura'
"let g:livepreview_engine = 'tectonic' 
let g:livepreview_cursorhold_recompile = 0
autocmd Filetype tex setl updatetime=1
autocmd Filetype tex set background=light

autocmd Filetype tex colorscheme everforest
autocmd Filetype tex let g:airline_theme = 'everforest'



"=====|Markdown|=====
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


"=====|GCode|=====
Plug 'wilriker/gcode.vim'


"=====|Interface|=====
Plug 'mhinz/vim-startify' "Nice start window
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "Highlight colors

let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\ ]
"let g:Hexokinase_highlighters = ['foreground']
let g:Hexokinase_highlighters = ['backgroundfull']

if has('termguicolors')
  set termguicolors
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"Colorscheme
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/everforest'

let g:everforest_background = 'hard'
let g:everforest_enable_italic = 1
let g:everforest_spell_foreground = 'colored'
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_diagnostic_line_highlight = 1

let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_number_column = 'bg1'
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_invert_selection = 1

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'gruvbox'
"let g:airline_powerline_fonts = 1

"Icons
Plug 'ryanoasis/vim-devicons'
Plug 'cj/vim-webdevicons'
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

call plug#end()
set background=dark
colorscheme gruvbox 

autocmd! bufwritepost ~/.vimrc source ~/.vimrc
