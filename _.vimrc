" 关闭 vi 兼容模式
set nocompatible

""""""""""""""""""""""""""
" Load vim plugin manager
""""""""""""""""""""""""""
execute pathogen#infect()

""""""""""""""""""""""
" Base
""""""""""""""""""""""

" enable syntax highlighting
syntax enable

" 配色方案
colorscheme desert

" show line numbers
set number
" show a visual line under the cursor's current line
set cursorline

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" set tabs to have 4 spaces
set tabstop=4

" 回到上次退出的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"""""""""""""""""""""""
" Search
"""""""""""""""""""""""

" 搜索时忽略大小写
set ignorecase
" 禁止在搜索到文件两端时重新搜索
set nowrapscan
" 输入搜索内容时就显示搜索结果
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch


"""""""""""""""""""""""
" Status
"""""""""""""""""""""""

" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2
" 设置在状态行显示的信息
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "")
	return curdir
endfunction

function! HasPaste()
	if &paste
		return '[PASTE]'
	else
		return ''
	endif
endfunction


""""""""""""""""""""""""""
" ENCODING SETTINGS
""""""""""""""""""""""""""

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1


"""""""""""""""""""""""""""""""
" File type
"""""""""""""""""""""""""""""""

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


"""""""""""""""""""""""""""
" omni complete
"""""""""""""""""""""""""""

function! SetPythonFile()
	set omnifunc=pythoncomplete#Complete

	" expand tabs into spaces
	set expandtab
	set textwidth=84
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	" indent when moving to the next line while writing code
	set autoindent
	" show the matching part of the pair for [] {} and ()
	set showmatch
	" enable all Python syntax highlighting features
	let python_highlight_all = 1
endfunction

function! SetYamlFile()
	set expandtab
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
endfunction

autocmd FileType python call SetPythonFile()
autocmd FileType yaml call SetYamlFile()


"""""""""""""""""""""""""""""
" Window Splits
"""""""""""""""""""""""""""""
" Vertical Split : Ctrl+w + v
" Horizontal Split: Ctrl+w + s
" Close current windows: Ctrl+w + q
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"""""""""""""""""""""""""""""
" Plugin config
"""""""""""""""""""""""""""""
" Task lists
" usage: \td
map <leader>td <Plug>TaskList

" Revision History
" usage: \g
map <leader>g :GundoToggle<CR>

" NERD Tree
" file browser, https://github.com/scrooloose/nerdtree.git
" usage: \n
map <leader>n :NERDTreeToggle<CR>

" Documentation
" pydoc
" usage: \pw

" vim-flake8
" checker: pep8, pyflakes and co. https://github.com/nvie/vim-flake8.git
" usage: \8
autocmd FileType python map <leader>8 :call Flake8()<CR>

" Ctrl-p
" super searching file. https://github.com/ctrlpvim/ctrlp.vim
" usage: ctrl-p
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'

" ag
" the silver searcher. https://github.com/rking/ag.vim.git
" usage: :Ag [options] {pattern} [{directory}]
set runtimepath^=~/.vim/bundle/ag.vim
let g:ag_working_path_mode="r"
