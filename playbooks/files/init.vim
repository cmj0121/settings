" Author   cmj <cmj@cmj.tw>
" Version  v0.1.0

" --------------------------- "
" Global Environment          "
" --------------------------- "
set tabstop=4				" tab equals to number of spaces
set softtabstop=4
set shiftwidth=4
set nosmarttab
set noautoindent
set foldenable
set foldmethod=indent
set foldignore=
set showmatch				" show matching
set hlsearch				" highlight search result
set incsearch				" incremental search result
set modelines=4
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

" change to the vim color scheme
colorscheme vim

" --------------------------- "
" customized syntax highlight "
" --------------------------- "
hi Whitespace cterm=NONE ctermbg=NONE ctermfg=gray
hi Visual cterm=NONE ctermbg=yellow ctermfg=black

" --------------------------- "
" Shortcut / Hotkey           "
" --------------------------- "
imap <S-tab> <c-p>
map <C-l> :source $MYVIMRC<CR> :echo "reload config"<CR>
map <C-w> :tabclose<CR>
map <C-n> :tabnext<CR>
map <C-p> :tabprevious<CR>
nnoremap sf :Telescope find_files search_dirs={"."}<CR>
nnoremap ss :Telescope live_grep search_dirs={"."}<CR>
nnoremap sb :Telescope buffers<CR>

" --------------------- "
" global syntax setting "
" --------------------- "
augroup fsyntax
autocmd BufRead,BufNewFile *.zg   setlocal ts=4 sw=4 ft=zerg
autocmd BufRead,BufNewFile *.tf	  setlocal ts=2 sw=2 expandtab ft=terraform
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
map tt :NERDTree<CR>
map li :LspInfo<CR>
map lr :LspRestart<CR>
map ll :LspLog<CR>

call plug#begin('~/.vim/plugged')
Plug 'numToStr/Comment.nvim'           " quickcomment the source code
Plug 'rhysd/git-messenger.vim'         " reveal the commit messages under the cursor
Plug 'nvim-lua/plenary.nvim'           " All the lua functions I don't want to write twice
Plug 'github/copilot.vim'              " Neovim plugin for GitHub Copilot
" editor
Plug 'scrooloose/nerdtree'             " A tree explorer plugin for vim.
Plug 'nvim-telescope/telescope.nvim'   " Find, Filter, Preview, Pick. All lua, all the time.
Plug 'neovim/nvim-lspconfig'
" syntax highlight
Plug 'hashivim/vim-terraform'
Plug 'dart-lang/dart-vim-plugin'
call plug#end()

" --------------------------- "
"  extra launcher             "
" --------------------------- "
lua << __EOF__
-- use for the numToStr/Comment.nvim
-- default keymap
-- <g> <c>  Line-comment keymap
-- <g> <b>  Block-comment keymap
local cmt = require("Comment")
cmt.setup()

-- use for neovim/nvim-lspconfig
local lspconfig = require('lspconfig')
lspconfig.asm_lsp.setup{}
lspconfig.awk_ls.setup{}
-- npm install -g dockerfile-language-server-nodejs
lspconfig.dockerls.setup {
    settings = {
        docker = {
	    languageserver = {
	        formatter = {
		    ignoreMultilineInstructions = true,
		},
	    },
	}
    }
}
-- go install github.com/nametake/golangci-lint-langserver@latest
-- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
lspconfig.golangci_lint_ls.setup{}
lspconfig.dartls.setup{}
lspconfig.pylsp.setup{
  settings = {
	pylsp = {
        plugins = {
          autopep8 = {enabled = false},
          pycodestyle = {enabled = false},
          pyflakes = {enabled = false},
          ruff = {enabled = true},
          mypy = {enabled = true, live_mode = true},
      }
    }
  }
}
__EOF__
