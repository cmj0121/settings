" Author   cmj <cmj@cmj.tw>
" Version  v0.0.1

" -------------------- "
" Global Environment   "
" -------------------- "
syntax on

" set the tab/space width
set tabstop=4				" tab equals to number of spaces
set softtabstop=4
set shiftwidth=4
set nosmarttab
set noautoindent
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
set mouse=
set number					" add line numbers
set numberwidth=4
set colorcolumn=128			" set the column border for good coding style
set ruler					" show the line and column number of the cursor
set fsync					" fsync() will be called after saving
set updatecount=100			" written to disk if typing number of chars
set updatetime=200			" written to disk if nothing is typed
set visualbell				" use visual bell instead of beeping
set exrc

"set list					" displayed the empty characters
"set listchars=tab:>.

" customized syntax highlight
hi Whitespace cterm=NONE ctermbg=NONE ctermfg=gray
hi Visual cterm=NONE ctermbg=yellow ctermfg=black

" ------------------ "
" Shortcut / Hotkey  "
" ------------------ "
imap <S-tab> <c-p>
map <C-l> :source $MYVIMRC<CR> :echo "reload config"<CR>
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
autocmd BufRead,BufNewFile *.dart setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.zg   setlocal ts=4 sw=4 ft=zerg
augroup END

" --------------------- "
" skeleton              "
" --------------------- "
augroup templates
autocmd BufNewFile Makefile  0r ~/.vim/templates/skeleton.Makefile
augroup END

" --------------------- "
" Plugins               "
" --------------------- "
map <C-i> :PlugInstall<CR>
map <C-u> :PlugUpdate<CR> :PlugUpgrade<CR>

call plug#begin('~/.vim/plugged')
Plug 'numToStr/Comment.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
call plug#end()

lua << __EOF__
-- use for the numToStr/Comment.nvim
-- default keymap
-- <g> <c>  Line-comment keymap
-- <g> <b>  Block-comment keymap
local cmt = require("Comment")
cmt.setup()

-- use for jose-elias-alvarez/null-ls.nvim
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- for schell script
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.diagnostics.commitlint,
		null_ls.builtins.diagnostics.hadolint,
		-- for Python
		null_ls.builtins.diagnostics.actionlint,
		null_ls.builtins.diagnostics.flake8,
	    null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.formatting.reorder_python_imports,
		-- for Go
		null_ls.builtins.code_actions.gomodifytags,
		null_ls.builtins.code_actions.impl,
		-- for GitHub Action
		null_ls.builtins.diagnostics.actionlint,
		-- for Grammarly
		null_ls.builtins.diagnostics.write_good,
	},
})
__EOF__
