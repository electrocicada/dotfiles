set nocompatible
"let g:mapleader=','
nnoremap <SPACE> <Nop>
let mapleader=" "

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

"set rtp+=~/.vim/tabnine-vim

"Basic settings
syntax on
set number relativenumber
set t_Co=256
set t_ut = ""
set encoding=utf8
set guifont=DroidSansMono\ Nerd\ Font\ 11

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Highlight insert mode
"set cursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

"Highlight vertical line in .go files
if (&ft=='go')
  set colorcolumn=90
  highlight ColorColumn ctermbg=darkgray 
endif

"set keymap=russian-jcukenwin
set keymap=ukrainian-jcuken
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set wrap
set linebreak
"set textwidth=90

"Tabs
set tabstop=2
set expandtab
set smarttab
set softtabstop=2
set shiftwidth=2

"Search
set hlsearch
set incsearch
nmap <silent> <Leader>/ :nohlsearch<CR>

"Don't make chaos on my display
set nowrap
set backspace=indent,eol,start
set nojoinspaces
set nofoldenable

"Disable backups
set nobackup
set noswapfile


"Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'

"i3 confif syntax highlighting
Plug 'mboughaba/i3config.vim'
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"In test:
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>

Plug 'nathanaelkane/vim-indent-guides'
autocmd FileType c :IndentGuidesEnable
autocmd FileType cpp :IndentGuidesEnable
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdcommenter'
let g:NERDCustomDelimiters = { 'c': { 'left': '//' }  }

Plug 'kien/ctrlp.vim'

"Plug 'ryanoasis/vim-devicons'
let g:airline_powerline_fonts = 1


Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

"Colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
"let g:gruvbox_italic=1
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cocopon/iceberg.vim'
Plug 'hzchirs/vim-material'
Plug 'bitfield/vim-gitgo'
Plug 'sainnhe/everforest'
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'

Plug 'sheerun/vim-polyglot'

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

"set completeopt-=preview


"Plug 'junegunn/goyo.vim'
"nmap <silent> <Leader>g :Goyo<CR>

"Better C/C++ highlight
Plug 'octol/vim-cpp-enhanced-highlight'
let c_no_curly_error=1

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'everforest'

 "let g:airline#extensions#tabline#enabled = 1
 "let g:airline#extensions#tabline#left_sep = ' '
 "let g:airline#extensions#tabline#left_alt_sep = '|'
 "let g:airline#extensions#tabline#formatter = 'default'

"LSP
Plug 'ycm-core/YouCompleteMe'
let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1

"Vim markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


Plug 'mhinz/vim-startify'

"Some scrolling features
Plug 'preservim/vim-wheel'
let g:wheel#map#up   = '<c-k>'
let g:wheel#map#down = '<c-j>'

let g:wheel#map#mouse = 1      " 1=natural, 0=disable, -1=reverse

Plug 'psliwka/vim-smoothie'

"LaTeX
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"let g:livepreview_previewer = 'okular'
let g:livepreview_previewer = 'zathura'
"let g:livepreview_engine = 'tectonic' 
let g:livepreview_cursorhold_recompile = 0
autocmd Filetype tex setl updatetime=1
autocmd Filetype tex set background=light
 
Plug 'gcollura/vim-masm'

Plug 'wilriker/gcode.vim'

call plug#end()



if has('termguicolors')
  set termguicolors
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
let g:everforest_background = 'hard'
let g:everforest_enable_italic = 1
let g:everforest_spell_foreground = 'colored'
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_diagnostic_line_highlight = 1

"Colorscheme selector: 
"colorscheme nord
"colorscheme gruvbox 
"colorscheme onehalfdark
colorscheme everforest


"Alacrittu colors patch
if &term == "alacritty"        
    let &term = "xterm-256color"
endif

"Automatic update after saving the file
autocmd! bufwritepost ~/.vimrc source ~/.vimrc
autocmd! bufwritepost ~/.config/i3/config :!sh -xc 'i3-msg restart'
autocmd! bufwritepost ~/.config/i3starus/config :!sh -xc 'i3-msg restart'
