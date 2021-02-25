" vim-bootstrap 

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "c,python,rust"
let g:vim_bootstrap_editor = "nvim"         " nvim or vim
let g:vim_bootstrap_theme = "dracula"
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif 
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
" Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'


" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" python
"" Python Bundle
" Plug 'davidhalter/jedi-vim'
" Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
""Shada
" let shada=expand("~/.local/share/nvim/shada")

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set autoindent
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set list
set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:·

set ruler
set number
set rnu

let no_buffers_menu=1
let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox
" colorscheme dracula


"" Disable the blinking cursor.
set gcr=a:blinkon0

au TermEnter * setlocal scrolloff=0
au TermLeave * setlocal scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
" let g:airline_theme = 'powerlineish'
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline_skip_empty_sections = 1


"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Helpers: 
nmap <Leader>. :FZF<CR>
vmap <Leader><Leader> <Esc>
cmap <Leader><Leader> <Esc>
imap <Leader><Leader> <Esc>
omap <Leader><Leader> <Esc>
tmap <Leader><Leader> <Esc>


"" Split
noremap <Leader>j :<C-u>split<CR>
noremap <Leader>l :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" " session management
" nnoremap <leader>so :OpenSession<Space>
" nnoremap <leader>ss :SaveSession<Space>
" nnoremap <leader>sd :DeleteSession<CR>
" nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>/ :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

""" fzf.vim
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

"" The Silver Searcher
"if executable('ag')
"  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"  set grepprg=ag\ --nogroup\ --nocolor
"endif

"" ripgrep
"if executable('rg')
"  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"  set grepprg=rg\ --vimgrep
"  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"endif

"cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
"nnoremap <silent> <leader>b :Buffers<CR>
"nnoremap <silent> <leader>e :FZF -m<CR>
""Recovery commands from history through FZF
"nmap <leader>y :History:<CR>

"" snippets
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsEditSplit="vertical"

"" ale
"let g:ale_linters = {}

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


"" Open current line on GitHub
" nnoremap <Leader>o :.Gbrowse<CR>

source $HOME/.config/nvim/conf.d/coc.vim

