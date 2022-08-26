"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基础
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭 vi 兼容模式
set nocompatible
set backspace=indent,eol,start

" 开启语法高亮
syntax enable

" 显示行号
set number
" 显示相对行号
set relativenumber
" 背景差异游标所在行
set cursorline

" 背景差异显示列,按字符数算
set cc=79

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

" 设置tab为4个空格
set tabstop=4

""""""""
" 搜索
""""""""
" 搜索时忽略大小写
set ignorecase
" 禁止在搜索到文件两端时重新搜索
set nowrapscan
" 输入搜索内容时就显示搜索结果
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch

""""""""""""
" 编码设置
""""""""""""
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"""""""
" 状态
"""""""
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

"""""""""""""""""""""""""""
" omni complete
"""""""""""""""""""""""""""
" python
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

" yaml
function! SetYamlFile()
	set expandtab
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
endfunction

" gdscript
function! GodotSettings()
    set foldmethod=expr
    set tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunction

"autocmd FileType python call SetPythonFile()
autocmd FileType yaml call SetYamlFile()
autocmd FileType gdscript call GodotSettings()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件管理
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 加载插件管理 路径为配置文件底下的plugged
call plug#begin()

" 配色方案
Plug 'liuchengxu/space-vim-dark'
" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 电力字体
Plug 'Lokaltog/powerline'
" 文件管理
Plug 'preservim/nerdtree'
" 注释
Plug 'preservim/nerdcommenter'
" 全文查找
Plug 'rking/ag.vim'
" 模糊查找
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" git
Plug 'tpope/vim-fugitive'
" 在最后一个编辑位置打开文件
Plug 'farmergreg/vim-lastplace'
" 突出光标下的单词及其所有出现
Plug 'dominikduda/vim_current_word'
" 缩进提示(对齐线)
Plug 'Yggdroot/indentLine'
" 对齐
Plug 'junegunn/vim-easy-align'


" 自动补全
Plug 'neoclide/coc.nvim'
"Plug 'dense-analysis/ale'


" 语言相关
" python
"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'

" Godot
"Plug 'habamax/vim-godot'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
" 配色方案
"""""""""""
set t_Co=256
set background=dark
" 主题
colorscheme space-vim-dark
" 背景透明
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

"""""""""""""""
" vim-airline
""""""""""""""
let g:airline_theme='violet'
" sudo apt-get install fonts-powerline
let g:airline_powerline_fonts = 1
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

""""""""""""""""
" 文件管理
""""""""""""""""
" NERD Tree
" file browser, https://github.com/preservim/nerdtree
" usage: ctrl-n
map <C-n> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1

" 当使用vim没有带文件参数时,自动打开NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当使用vim带的参数是文件夹时,自动打开NERDTree
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"当 NERDTree 是最后一个窗口时,退出vim
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" 当 NERDTree 是最后一个窗口时,关闭选项卡
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"""""""
" 注释
"""""""
" NERD Commenter
" comment https://github.com/preservim/nerdcommenter
" default mappings
" [count]<leader>c<space>
let g:NERDDefaultAlign = 'left'
let NERDTreeIgnore = ['\.pyc$']

"""""""""""""""
" 全文查找
"""""""""""""""
" ag.vim
" https://github.com/rking/ag.vim
" usage: :Ag [options] {pattern} [{directory}]
" need:  the silver searcher
" 快捷键
" e  打开文件关闭搜索窗口
" go 预览文件(打开文件,但游标还在搜索窗口)
let g:ag_working_path_mode="r"

""""""""""""""
" 模糊查找文件
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

""""""""""""
" 大纲式导航
""""""""""""
" tagbar
" https://github.com/majutsushi/tagbar
" usage: \b

"map <leader>b :TagbarToggle<CR>

" 使用LeaderF的bufTag
noremap <leader>b :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>


"""""""
" 对齐
"""""""
" usage: markdowm 表格对其 gaip*|
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


""""""""""""""
" 自动补全
"""""""""""""
" nodejs: curl -sL install-node.vercel.app/lts | sudo bash
" npm: curl -L https://npmjs.org/install.sh | sudo sh 
" npm install yarn
" cd coc.vim && yarn install && yarn build
" 安装拓展 :CocInstall coc-pyright

" ALE
"let g:ale_open_list = 1
"let g:ale_virtualtext_cursor = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""
" key short
""""""""""""""""""""
" tabs
map gt :bn<CR>
map gT :bp<CR>


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
