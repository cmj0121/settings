" Author   cmj <cmj@cmj.tw>
" Version  v0.0.1

" -------------------- "
" Global Environment   "
" -------------------- "
syntax on

" set the tab/space width
set tabstop=4				" tab equals to number of spaces
set softtabstop=4
" control the folder setting "
set foldenable
set foldmethod=indent
set foldignore=
" spell checking and search "
"set spell
"set spelllang=en,cjk
"set spellfile=~/.config/nvim/spell/utf-8.add
set showmatch				" show matching
set hlsearch				" highlight search result
set incsearch				" incremental search result
" enable the footer control for vim "
set modelines=4
" performance and preference "
set number					" add line numbers
set numberwidth=4
set colorcolumn=128			" set the column border for good coding style
set ruler					" show the line and column number of the cursor
set fsync					" fsync() will be called after saving
set updatecount=100			" written to disk if typing number of chars
set updatetime=200			" written to disk if nothing is typed
set visualbell				" use visual bell instead of beeping
set exrc


" ------------------ "
" Shortcut / Hotkey  "
" ------------------ "
imap <S-tab> <c-p>
map <C-h> :%! xxd<CR>
map <C-g> :w <CR> :!make clean && make -j4<CR>
" Window Tab Control "
map <C-w> :tabclose<CR>
map <C-n> :tabnext<CR>
map <C-p> :tabprevious<CR>

" --------------------- "
" global syntax setting "
" --------------------- "
augroup fsyntax
autocmd BufRead,BufNewFile *.yaml setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.yml  setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.py   setlocal ts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.html setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.htm  setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.js   setlocal ts=2 sw=2 expandtab
augroup END