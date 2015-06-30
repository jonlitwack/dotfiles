" Heavily based on https://github.com/dougblack/dotfiles/blob/master/.vimrc
" ... And then heavily modified by me to work for NeoVim
"
" don't bother with vi compatibility
set nocompatible
" Colors {{{
syntax enable   " enable syntax highlighting
" filetype off

" configure Plug
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
call plug#begin('~/.nvim/plugged')
" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

filetype on
" set t_Co=256
" set term=screen-256color
" }}}

" Miscellaneous {{{
set ttyfast
set backspace=indent,eol,start
" }}}

" Spaces & Tabs {{{
set tabstop=4       " 4 space tab
set expandtab       " use spaces for tabs
set softtabstop=4   " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
set breakindent     " Breaks wrapped text into its proper indent
set showbreak=\ \ "Adds space after break
set wrap            " Wrap lines
set ai              " Auto indent
set si              " Smart indent
set tw=72
set fo=cqt
set wm=0   " Sets text wrap to 72nd column - taken from http://blog.ezyang.com/2010/03/vim-textwidth/
" }}}

" UI Layout {{{
set number        " show line numbers
set showcmd       " show command in bottom bar
set nocursorline  " highlight current line
set wildmenu      " show a navigable menu for tab completion
set showmatch     " highlight matching parenthesis
" }}}

" Searching {{{
set ignorecase    " ignore case when searching
set incsearch     " search as characters are entered
set hlsearch      " highlight all matches
" }}}

" Folding {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}

" Line Shortcuts {{{
" See https://github.com/dougblack/dotfiles/blob/master/.vimrc for full list
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>c <Plug>Kwbd
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
inoremap jj <Esc>
tnoremap jj <C-\><C-n>
" }}}


set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set smartcase                                                " case-sensitive search if any caps
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif


" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
" extra rails.vim help
autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Automatically assign YCM to Omnicomplete
let g:tern_map_keys=1

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Go crazy!
if filereadable(expand("~/.nvimrc.local"))
  " In your .vimrc.local, you might like:
  "
  set autowrite
  " set nocursorline
  set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.nvimrc.local
endif
" # Vim Plugins
Plug 'reedes/vim-thematic'
Plug 'scrooloose/nerdtree'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'jiangmiao/auto-pairs'
Plug 'bling/vim-airline'
Plug 'ryanoasis/vim-webdevicons'
Plug 'flazz/vim-colorschemes'
Plug 'Valloric/YouCompleteMe'
" Plugin 'rdnetto/YCM-Generator'
Plug 'marijnh/tern_for_vim'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'othree/html5-syntax.vim'
" Plugin 'jistr/vim-nerdtree-tabs'
" Plugin 'godlygeek/csapprox'
Plug 'mhinz/vim-startify'

" # Authored Bundles
Plug 'reedes/vim-colors-pencil'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-one'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-wordy'

" # Color Bundles
Plug 'freeo/vim-kalisi'
Plug 'baskerville/bubblegum'
Plug 'chriskempson/base16-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'nanotech/jellybeans.vim'
Plug 'noahfrederick/vim-hemisu'"

call plug#end()
" Airline Settings {{{
let g:airline_powerline_fonts = 1
" }}}

" Thematic Settings {{{
let g:thematic#defaults = {
      \ 'airline-theme': 'solarized',
      \ 'colorscheme': 'solarized',
      \ 'fullscreen-background-color-fix': 1,
      \ 'sign-column-color-fix': 1,
      \ 'laststatus': 2,
      \ 'background': 'dark',
      \ 'font-size': 20,
      \ 'linespace': 0,}
let g:thematic#themes = {
      \ 'desert'     : { 'sign-column-color-fix': 1,
      \                  'columns': 80,
      \                  'lines': 30,
      \                  'linespace': 9,
      \                  'sign-column': 1,
      \                  'laststatus': 2,
      \                  'fold-column-color-mute': 1,
      \                  'number-column-color-mute': 1,
      \                  'typeface': 'Cutive Mono',
      \                },
      \ 'kalisi_dark'   :{'colorscheme': 'kalisi',
      \                  'background': 'dark',
      \                  'columns' : 80,
      \                  'lines' : 30,
      \                  'linespace': 9,
      \                  'sign-column': 1,
      \                  'laststatus': 2,
      \                  'fold-column-color-mute': 1,
      \                  'airline-theme': 'kalisi',
      \               },
      \ 'kalisi_light'  :{ 'colorscheme': 'kalisi',
      \                  'background': 'light',
      \                  'columns' : 80,
      \                  'lines' : 30,
      \                  'linespace': 9,
      \                  'sign-column': 1,
      \                  'laststatus': 2,
      \                  'fold-column-color-mute': 1,
      \                  'airline-theme': 'kalisi',
      \               },
      \ 'pencil_light':{ 'colorscheme': 'pencil',
      \                  'background': 'light',
      \                  'columns': 75,
      \                  'font-size': 20,
      \                  'fullscreen': 1,
      \                  'laststatus': 2,
      \                  'linespace': 8,
      \                  'airline-theme': 'light',
      \                  'typeface': 'Cousine',
      \                },
      \ 'pencil_dark': { 'colorscheme': 'pencil',
      \                  'background': 'dark',
      \                  'font-size': 20,
      \                  'fullscreen': 1,
      \                  'laststatus': 2,
      \                  'linespace': 8,
      \                  'airline-theme': 'badwolf',
      \                  'typeface': 'Cousine',
      \                },
      \ 'traditional': { 'colorscheme': 'pencil',
      \                  'background': 'light',
      \                  'font-size': 20,
      \                  'laststatus': 2,
      \                  'linespace': 8,
      \                  'typeface': 'Linux Libertine Mono O',
      \                },
      \ 'hemi_dark'  : { 'colorscheme': 'hemisu',
      \                  'font-size': 8,
      \                  'linespace': 0,
      \                  'typeface': 'Menlo',
      \                  'laststatus': 2,
      \                },
      \ 'hemi_lite'  : { 'colorscheme': 'hemisu',
      \                  'background': 'light',
      \                  'columns': 75,
      \                  'laststatus': 2,
      \                  'typeface': 'Fantasque Sans Mono',
      \                },
      \ 'matrix'     : { 'colorscheme': 'base16-greenscreen',
      \                  'font-size': 24,
      \                  'linespace': 9,
      \                  'typeface': 'Dot Matrix',
      \                  'laststatus': 2,
      \                },
      \ 'solar_dark' : { 'colorscheme': 'solarized',
      \                  'diff-color-fix': 1,
      \                  'sign-column': 1,
      \                  'sign-column-color-fix': 1,
      \                  'typeface': 'Source Code Pro Light',
      \                  'laststatus': 2,
      \                },
      \ 'solar_lite' : { 'colorscheme': 'solarized',
      \                  'background': 'light',
      \                  'font-size': 20,
      \                  'sign-column-color-fix': 1,
      \                  'typeface': 'Source Code Pro Medium',
      \                  'laststatus': 2,
      \                },
      \ 'embers' :     { 'colorscheme': 'base16-embers',
      \                  'diff-color-fix': 1,
      \                  'sign-column': 1,
      \                  'sign-column-color-fix': 1,
      \                  'typeface': 'Source Code Pro Light',
      \                  'laststatus': 2,
      \                  'airline-theme': 'base16-embers',
      \                },
      \ 'jellybeans' : { 'colorscheme': 'jellybeans',
      \                  'background': 'light',
      \                  'ruler': 1,
      \                  'laststatus': 2,},
      \ 'github'     : { 'background': 'light'  }}

colorscheme Solarized
let g:solarized_termcolors=16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set background=dark

" Javascript Settings {{{
let g:javascript_enable_domhtmlcss = 0
let b:javascript_fold = 1
" }}}

" Indent Guides Settings {{{
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" }}}
" Emmet Settings {{{
let g:user_emmet_expandabbr_key='<Tab>'
" }}}

" YouCompleteMe Settings {{{
let g:ycm_global_ycm_extra_conf=expand('~/.nvim/ycm_extra_conf.py')
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_tags_files=1
" }}}
" Syntastic Settings {{{
let g:syntastic_html_tidy_exec = 'tidy5'
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
" }}}

" WebDevIcons Settings {{{
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" }}}

" {{{NERDTREE Settings}}}
let NERDTreeShowHidden=1

" TMux Settings {{{
"tmux set-option -g utf8 on
:set tenc=utf8
" }}}

" Startify Settings {{{
let g:startify_session_dir = '~/.nvim/sessions'
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks', ]
" }}}
