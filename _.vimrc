""""""""""""""""""""""
" 基础
""""""""""""""""""""""

" 关闭 vi 兼容模式
set nocompatible

" 自动语法高亮
:syntax on

" 配色方案
colorscheme desert

" 显示行号
set number
" 突出显示当前行
set cursorline

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" 设定 tab 长度为 4
set tabstop=4


"""""""""""""""""""""""
" 搜索
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
" 状态栏
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
" 文件类型
"""""""""""""""""""""""""""""""

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


"""""""""""""""""""""""""""
" omni complete
"""""""""""""""""""""""""""

function! SetPythonFile()
	set omnifunc=pythoncomplete#Complete

	set expandtab
	set textwidth=84
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set autoindent
endfunction

function! SetYamlFile()
	set expandtab
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
endfunction

autocmd FileType python call SetPythonFile()
autocmd FileType yaml call SetYamlFile()


" Pathogen Plugin
"filetype off
"call pathogen#runtime_append_all_bundles()
"call pathogen#incubate()
"call pathogen#helptags()

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
" Task lists
"""""""""""""""""""""""""""""
" usage: \td
map <leader>td <Plug>TaskList

"""""""""""""""""""""""""""""
" Revision History
"""""""""""""""""""""""""""""
" usage: \g
map <leader>g :GundoToggle<CR>


"""""""""""""""""""""""""""""
" File Browser
"""""""""""""""""""""""""""""
" usage: \n
map <leader>n :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""
" Documentation
"""""""""""""""""""""""""'""
" pydoc
" usage: \pw

""""""""""""""""""""""""""""
" Pep8
""""""""""""""""""""""""""""
" install http://github.com/cburroughs/pep8.py 
" usage: \8
let g:pep8_map='<leader>8'
