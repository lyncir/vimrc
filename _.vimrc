" 关闭 vi 兼容模式
set nocompatible
set backspace=indent,eol,start

""""""""""""""""""""""""""
" Load vim plugin manager
""""""""""""""""""""""""""
" pathogen
execute pathogen#infect()
filetype plugin indent on

" plug
call plug#begin()
Plug 'liuchengxu/space-vim-dark'
"Plug 'liuchengxu/vim-better-default'
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Valloric/YouCompleteMe'
call plug#end()

""""""""""""""""""""""
" Base
""""""""""""""""""""""

" enable syntax highlighting
syntax enable

" show line numbers
set number
" relative line numbers
set relativenumber
" show a visual line under the cursor's current line
set cursorline

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" set tabs to have 4 spaces
set tabstop=4

" 回到上次退出的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" default copy line number
set viminfo='50,<1000,s100,h


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

"filetype on           " Enable filetype detection
"filetype indent on    " Enable filetype-specific indenting
"filetype plugin on    " Enable filetype-specific plugins


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
" usage: Ctrl-n
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" vim-flake8
" checker: pep8, pyflakes and co. https://github.com/nvie/vim-flake8.git
" usage: \8
"autocmd FileType python map <leader>8 :call Flake8()<CR>


" Ctrl-p
" super searching file. https://github.com/ctrlpvim/ctrlp.vim
" usage: ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }


" ag
" the silver searcher. https://github.com/rking/ag.vim.git
" usage: :Ag [options] {pattern} [{directory}]
set runtimepath^=~/.vim/bundle/ag.vim
let g:ag_working_path_mode="r"


" Syntastic
" syntax checking plugin https://github.com/vim-syntastic/syntastic.git
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
" disable python flake8 line to long error check
let g:syntastic_python_flake8_args = "--ignore=E501"
" disable style checking
"let g:syntastic_quiet_messages = {"type": "style"}
map <leader>8 :SyntasticToggleMode<CR>


" Surround
" quoting/partenthesizing made simple https://github.com/tpope/vim-surround
" Usage see doc
" cs"' : "Hello world!" -> 'Hello world!'
" ds" : "Hello world!" -> Hello world!


" Tagbar
" A class outline viewer https://github.com/majutsushi/tagbar
" Usage: \b
map <leader>b :TagbarToggle<CR>


" NERD Commenter
" comment https://github.com/scrooloose/nerdcommenter
" default mappings
" [count]<leader>c<space>
let g:NERDDefaultAlign = 'left'


" colorschemes
" https://github.com/flazz/vim-colorschemes.git
" vim-airline
" https://github.com/vim-airline/vim-airline
set t_Co=256
set background=dark
"color gruvbox
color space-vim-dark
let g:airline_theme='violet'
let g:Powerline_symbols='fancy'
let g:airline_powerline_fonts=1
let g:airline#extensions#default#layout = [
 \ [ 'a', 'b', 'c' ],
 \ [ 'x', 'y', 'z', 'error', 'warning' ]
 \ ]
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
if !exists('g:airline_powerline_fonts')
	let g:airline_left_sep='>'
	let g:airline_right_sep='<'
endif


" clear key_mapping
let g:vim_better_default_key_mapping = 0

""""""""""""""""""""
" key short
""""""""""""""""""""
" tabs
map gt :bn<CR>
map gT :bp<CR>

" Usage: F5
:nnoremap <F5> :buffers<CR>:buffer<Space>
