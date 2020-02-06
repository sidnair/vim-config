"""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'sidnair/molokai' " Syntax highlighting

" File fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

Plug 'dense-analysis/ale' " ALE linter

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Chrome
Plug 'preservim/nerdtree'
Plug 'bling/vim-airline'
Plug 'sjl/gundo.vim'
Plug 'mhinz/vim-signify'

" Utility
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'godlygeek/tabular'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdcommenter'
Plug 'ton/vim-bufsurf'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-scripts/listmaps.vim'

" JavaScript
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'

" TypeSript
Plug 'HerringtonDarkholme/yats.vim'
" Currently using this for :TSCodeFix - the rest goes through ALE
Plug 'mhartington/nvim-typescript', {'do': ':!install.sh \| UpdateRemotePlugins'}

" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'deoplete-plugins/deoplete-jedi' " Requires jedi
Plug 'tmhedberg/SimpylFold'
Plug 'jeetsukumaran/vim-pythonsense'

" CSS
Plug 'ap/vim-css-color'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Go
" ALE covers most of the functionality - this is helpful for directly running Go
" commands and for the omnifunc that provides autocomplete semantics to
" deoplete.
Plug 'fatih/vim-go'

call plug#end()


"""""""""""""""""""""""""
" Basic config
"""""""""""""""""""""""""

" Display options
syntax on
set cursorline
set number
set encoding=utf-8
set list!                       " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
if $TERM =~ '256color'
  set t_Co=256
elseif $TERM =~ '^xterm$'
  set t_Co=256
endif
colorscheme molokai

" Misc
filetype plugin indent on       " Do filetype detection and load custom file plugins and indent files
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set wildmode=list:longest,full  " Complete longest common match and show possible matches and wildmenu
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set updatecount=100             " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before the horizontal window border
set autochdir                   " Automatically cd into dir that the file is in
set visualbell t_vb=            " Disable error bells
set shortmess+=A                " Always edit file, even when swap file is found
set ttimeoutlen=50

" up/down on displayed lines, not real lines.
" Only change normal and visual/select mode so that operators aren't affected
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

" Formatting, indentation and tabbing
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=80
set formatoptions-=t formatoptions+=croql

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:1000
if !has('nvim')
  set viminfo+=n~/.vim/viminfo
endif

" ctags: recurse up to home to find tags. See
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" for an explanation and other ctags tips/tricks
set tags+=tags;$HOME

" Undo
set undolevels=10000
if has("persistent_undo")
  set undodir=~/.vim/undo       " Allow undoes to persist even after a file is closed
  set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" Save/restore view on close/open (folds, cursor, etc.)
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

au BufWinEnter * checktime
au WinEnter * checktime
" After updatetime ms of inactivity, check for external file modifications on next keypress
au CursorHold * checktime
" 100 recommended by vim-signify; bump this back to 1000 if it's causing
" problems
set updatetime=100


"""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""
let mapleader=","
let localmapleader=","

nmap <Leader>s :%s/
vmap <Leader>s :s/
nmap <Leader>S :%S/
vmap <Leader>S :S/

vnoremap . :normal .<CR>
vnoremap @ :normal! @

" Toggles
set pastetoggle=<F1>
" the nmap is just for quicker powerline feedback
nmap <silent> <F1>      :set invpaste<CR>
nmap          <F2>      :setlocal spell!<CR>
imap          <F2> <C-o>:setlocal spell!<CR>

map <Leader>/ :nohlsearch<cr>
" Global search and replace by default
set gdefault


" Make Y consistent with D and C
function! YRRunAfterMaps()
  nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
  nnoremap <silent> yy :<C-U>YRYankCount 'ddP'<CR>
endfunction

" Disable K for manpages - not used often and easy to accidentally hit
noremap K k

" Movement across splits
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

vmap s :!sort<CR>
vmap u :!sort -u<CR>
vmap c :!sort \| uniq -c<CR>

" shift+k -> like shift+j, but no extra space
noremap <S-k> Jx

" Write file when you forget to use sudo
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""
" Deoplete
let g:deoplete#enable_at_startup = 1
" Close preview window after leaving insert mode - https://github.com/Shougo/deoplete.nvim/issues/115#issuecomment-170237485
" autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
autocmd InsertLeave * silent! pclose!
" endif
" https://github.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
let g:deoplete#auto_complete_delay = 100
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


nnoremap <Leader>b :BufSurfBack<cr>
nnoremap <Leader>f :BufSurfForward<cr>

nnoremap <C-u> :GundoToggle<CR>

nnoremap <C-g> :NERDTreeFind<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1

let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets = '<c-h>'

nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

"cnext and cprev that wrap around
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
nnoremap ]e :Cnext<CR>
nnoremap [e :Cprev<CR>

" lnext and lprev that wrap around. Note that these generally match :ALENextWrap
" and :ALEPreviousWrap - if we start getting other items in the loc list we'll
" want to split lnext/lprev into separate shortcuts.
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
nnoremap ]r :Lnext<CR>
nnoremap [r :Lprev<CR>

" ALE
let g:ale_linters = {} " Override linters and fixers in ftplugin
let g:ale_fixers = {}
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

nnoremap <Leader>add :ALEGoToDefinition<CR>
nnoremap <Leader>adh :ALEGoToDefinitionInSplit<CR>
nnoremap <Leader>adv :ALEGoToDefinitionInVSplit<CR>
nnoremap <Leader>atd :ALEGoToTypeDefinition<CR>
nnoremap <Leader>ath :ALEGoToTypeDefinitionInSplit<CR>
nnoremap <Leader>atv :ALEGoToTypeDefinitionInVSplit<CR>
nnoremap <Leader>ar :ALEFindReferences<CR>
nnoremap <Leader>ah :ALEHover<CR>
nnoremap <Leader>an :ALERename<CR>
nnoremap <Leader>as :ALESymbolSearch 
" Putting here so all the related shortcuts are in one place, but this should
" move to ftplugin/ files if we keep this long-term.
nnoremap <Leader>af :TSGetCodeFix<CR>
" Some excluded ALE commands:
" - :ALEGoToTypeDefinition to work reliably
" - :ALEOrganizeImports exists but is tsserver only. Save hooks should handle
"   this, so not adding a mapping
nnoremap <Leader>ak :GoDoc<CR>

" Put a space around comment markers
let g:NERDSpaceDelims = 1

nnoremap <C-y> :YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_manual_clipboard_check = 0
let g:yankring_max_history = 10000

let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" https://www.reddit.com/r/vim/comments/cas2ic/how_to_ripgrep_from_project_root_with_fzfvim/
let g:rooter_use_lcd = 1
let g:rooter_manual_only = 1

" FZF
set rtp+=/usr/local/opt/fzf
set rtp+=/usr/local/bin/rg

" skip gitignored files; 'ag -g ""' would also work
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --smart-case'
nmap <silent> <leader>, :History<CR>

command! -bang -nargs=* Files call fzf#vim#files(FindRootDirectory())
nmap <silent> <leader>. :Files<CR>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>), 1, {"dir": FindRootDirectory()})
nnoremap <Leader>r :Rg!<Space>
nnoremap <Leader>R :Rg! <C-R><C-W>


noremap \= :Tabularize /=<CR>
noremap \: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap \> :Tabularize /=><CR>
noremap \, :Tabularize /,\zs/l0l1<CR>
noremap \{ :Tabularize /{<CR>
noremap \\| :Tabularize /\|<CR>

"" Rainbow config
let g:rainbow_conf = { 'ctermfgs': ['red', 'yellow', 'green', 'cyan', 'magenta', 'red', 'yellow', 'green', 'cyan', 'magenta'] }
let g:rainbow_matching_filetypes = ['lisp', 'scheme', 'clojure', 'html']

function s:load()
  if count(g:rainbow_matching_filetypes, &ft) > 0
    call rainbow#hook()
  endif
endfunction

augroup rainbow
  autocmd!
  autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * nested call s:load()
augroup END

highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change            = '='

"""""""""""""""""""""""""
" Local config
"""""""""""""""""""""""""
so ~/.vim/vimrc.mine
