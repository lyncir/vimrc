" 关闭 vi 兼容模式
set nocompatible
set backspace=indent,eol,start

""""""""""""""""""""""""""
" Load vim plugin manager
""""""""""""""""""""""""""
" pathogen
execute pathogen#infect()
filetype plugin indent on

" plug 插件管理
call plug#begin()

Plug 'liuchengxu/space-vim-dark'
"Plug 'liuchengxu/vim-better-default'
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 文件浏览
Plug 'preservim/nerdtree'
" 注释
Plug 'preservim/nerdcommenter'
" 全文搜索
Plug 'rking/ag.vim'
" 自动补全
"Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim'
" 模糊查找
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" 语言包(自动缩进?有改主题)
Plug 'Vimjas/vim-python-pep8-indent'
" 电源线(状态栏)
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" 语法校验
Plug 'vim-syntastic/syntastic'
" flake8
Plug 'nvie/vim-flake8'
" Godot
"Plug 'habamax/vim-godot'

call plug#end()

""""""""""""""""""""""
" 基础
""""""""""""""""""""""

" 开启语法高亮
syntax enable

" 显示行号
set number
" 显示相对行号
set relativenumber
" 背景差异游标所在行
set cursorline

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" 设置tab为4个空格
set tabstop=4

" 回到上次退出的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" default copy line number
set viminfo='50,<1000,s100,h

" 背景差异显示列,按字符数算
set cc=79


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
" 状态
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
" 编码设置
""""""""""""""""""""""""""

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1


"""""""""""""""""""""""""""""""
" 文件类型
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

"autocmd FileType python call SetPythonFile()
"autocmd FileType yaml call SetYamlFile()


"""""""""""""""""""""""""""""
" 窗口分割
"""""""""""""""""""""""""""""
" 左右分割: Ctrl+w + v
" 上下分割: Ctrl+w + s
" 关闭当前窗口: Ctrl+w + q
" 切换窗口: Ctrl+w + jklh
" 调整窗口大小: Ctrl+w + 数值 + >/<
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""
""""""""""""""
" 查找文件
""""""""""""""
" ctrlp.vim
" https://github.com/ctrlpvim/ctrlp.vim
" usage: ctrl-p
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'

"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_custom_ignore = {
"            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"            \ 'file': '\v\.(exe|so|dll)$',
"            \ 'link': 'some_bad_symbolic_links',
"            \ }

" LeaderF
" https://github.com/Yggdroot/LeaderF.git
" usage: ctrl-p
let g:Lf_ShortcutF = '<C-P>'
" 如果使用的话,只会搜索仓库内的文件
let g:Lf_UseVersionControlTool = 0


""""""""""""""""
" 文件管理
""""""""""""""""
" NERD Tree
" file browser, https://github.com/scrooloose/nerdtree.git
" usage: ctrl-n
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""""""""""""""
" 全文查找
"""""""""""""""
" ag.vim
" https://github.com/rking/ag.vim.git
" usage: :Ag [options] {pattern} [{directory}]
" need:  the silver searcher
let g:ag_working_path_mode="r"


"""""""""""
" 自动补全
"""""""""""
" jedi-vim
" https://github.com/davidhalter/jedi-vim.git
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


"""""""""""
" 语法校验
"""""""""""
" syntastic
" https://github.com/vim-syntastic/syntastic.git
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
" disable python flake8 line to long error check
let g:syntastic_python_flake8_args = "--ignore=E501,E402,W503"
" disable style checking
"let g:syntastic_quiet_messages = {"type": "style"}
map <leader>8 :SyntasticToggleMode<CR>


"""""""""
" 大纲栏
"""""""""
" tagbar
" https://github.com/majutsushi/tagbar
" usage: \b

"map <leader>b :TagbarToggle<CR>

" 使用LeaderF的bufTag
noremap <leader>b :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>


"""""""
" 注释
"""""""
" NERD Commenter
" comment https://github.com/scrooloose/nerdcommenter
" default mappings
" [count]<leader>c<space>
let g:NERDDefaultAlign = 'left'
let NERDTreeIgnore = ['\.pyc$']


""""""""""
" 其它
"""""""""
" Task lists
" usage: \td
map <leader>td <Plug>TaskList


" Revision History
" usage: \g
map <leader>g :GundoToggle<CR>


" vim-flake8
" checker: pep8, pyflakes and co. https://github.com/nvie/vim-flake8.git
" usage: \8
"autocmd FileType python map <leader>8 :call Flake8()<CR>


" Surround
" quoting/partenthesizing made simple https://github.com/tpope/vim-surround
" Usage see doc
" cs"' : "Hello world!" -> 'Hello world!'
" ds" : "Hello world!" -> Hello world!


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

" TaskList
" git@github.com:vim-scripts/TaskList.vim.git
" Usage: \t
let g:tlTokenList = ["FIXME", "TODO", "NOTE"]
let g:tlWindowPosition = 1
map <leader>t :TaskList<CR>
"noremap <Leader>t :noautocmd vimgrep /TODO/j **/*.py<CR>:cw<CR>



""""""""""""""""""""""""
" add python file header
""""""""""""""""""""""""
let g:header_field_author = 'lyncir'

autocmd bufnewfile *.py so /home/lyncir/.vim/py_header.txt
autocmd bufnewfile *.py ks|call NewCreate()|'s
fun NewCreate()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/:create by:/s/:create by:.*/:create by: " . g:header_field_author
  exe "1," . l . "g/:date:/s/:date:.*/:date: " . strftime("%Y-%m-%d %H:%M:%S (%z)")
endfun

" 游标返回
autocmd Bufwritepre,filewritepre *.py execute "normal ma"

"autocmd Bufwritepre,filewritepre *.py ks|call LastMod()|'s
"fun LastMod()
"  if line("$") > 50
"    let l = 50
"  else
"    let l = line("$")
"  endif
"  exe "1," . l . "g/:last modified date:/s/:last modified date:.*/:last modified date: " .
"  \ strftime("%Y-%m-%d %H:%M:%S (%z)")
"  exe "1," . l . "g/:last modified by:/s/:last modified by:.*/:last modified by: " .
"  \ g:header_field_author
"endfun
"" 游标返回
"autocmd bufwritepost,filewritepost *.py execute "normal `a"

" 设置背景透明(放到最后)
hi Normal  ctermfg=252 ctermbg=none
