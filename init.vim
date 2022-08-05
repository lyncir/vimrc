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
"set shiftwidth=4

" 设置tab为4个空格
"set tabstop=4

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件管理
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 加载插件管理 路径为配置文件底下的plugged
call plug#begin(stdpath('config') . '/plugged')

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
" 缩进提示
Plug 'lukas-reineke/indent-blankline.nvim'


" 自动补全
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
"A good completion plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'


" 语言相关
" python
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'

" Godot
Plug 'habamax/vim-godot'


call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
" 配色方案
"""""""""""
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

""""""""""""""
" 自动补全
"""""""""""""
set completeopt=menu,menuone,noselect

lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Setup lsp installer
require("nvim-lsp-installer").setup {}

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
}
require('lspconfig')['html'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
require('lspconfig')['cssls'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
require'lspconfig'.gdscript.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  -- Supertab-like completion.
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  -- Groups of sources.
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
})
EOF


""""""""
" Pthon	
""""""""
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
" Godot
"""""""""
let g:godot_executable = '/opt/godot/Godot_v4.0-alpha13_linux.64'

func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clear key_mapping
let g:vim_better_default_key_mapping = 0

""""""""""""
" 窗口分割
""""""""""""
" 左右分割: Ctrl+w + v
" 上下分割: Ctrl+w + s
" 关闭当前窗口: Ctrl+w + q
" 切换窗口: Ctrl+w + jklh
" 调整窗口大小: Ctrl+w + 数值 + >/<
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tabs
map gt :bn<CR>
map gT :bp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 其它
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""
" add python file header
""""""""""""""""""""""""
let g:header_field_author = 'lyncir'

autocmd bufnewfile *.py so /home/lyncir/Repos/nvim/py_header.txt
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

" 设置背景透明(放到最后)
"hi Normal  ctermfg=252 ctermbg=none
