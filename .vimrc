set nocompatible              " required
" 开启文件类型侦测
filetype on                  " required
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" vim 自身命令行模式智能补全
set wildmenu
" 搜索时大小写不敏感
set ignorecase
set encoding=utf-8 " The encoding displayed.
set fileencodings=utf-8,ucs-bom,GB2312,big5 " The encoding written to file.
" 保持在光标上下最少行数
set scrolloff=4
" 退格键可以删除东西
set backspace=indent,eol,start
let g:pymode_python='python3'
" 禁止显示滚动条
" set guioptions-=l
" set guioptions-=L
" set guioptions-=r
" set guioptions-=R
" 禁止显示菜单和工具条
" set guioptions-=m
" set guioptions-=T
" 提示窗口出现在下方
set splitbelow

set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=NONE ctermfg=NONE guibg=darkred guifg=yellow
hi CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=yellow
set smartindent
set showmatch " Show matching brackets.
let python_highlight_all=1
" //搜索选中文本
vnoremap // y/<c-r>"<cr>
" 让vim记忆上次编辑的位置
autocmd BufReadPost *
			\ if line("'\"")>0&&line("'\"")<=line("$") |
			\	exe "normal g'\"" |
            \ endif

au Filetype python set textwidth=98
au Filetype python set fileformat=unix
autocmd Filetype python set foldlevel=99
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!clear"
		exec "!time python %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		" exec "!go build %<"
		exec "!time go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	endif
endfun
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"
" require yapf
Plugin 'Chiel92/vim-autoformat'
nnoremap <F3> :Autoformat<CR>
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:formatter_yapf_style = 'google'
"
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
			\ ['brown',       'RoyalBlue3'],
			\ ['Darkblue',    'SeaGreen3'],
			\ ['darkgray',    'DarkOrchid3'],
			\ ['darkgreen',   'firebrick3'],
			\ ['darkcyan',    'RoyalBlue3'],
			\ ['darkred',     'SeaGreen3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['brown',       'firebrick3'],
			\ ['gray',        'RoyalBlue3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['Darkblue',    'firebrick3'],
			\ ['darkgreen',   'RoyalBlue3'],
			\ ['darkcyan',    'SeaGreen3'],
			\ ['darkred',     'DarkOrchid3'],
			\ ['red',         'firebrick3'],
			\ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"
Plugin 'Lokaltog/vim-powerline'
" Plugin 'https://github.com/bling/vim-airline'
"
Plugin 'Valloric/YouCompleteMe'
"默认配置文件路径"
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
" python解释器路径"
" let g:ycm_path_to_python_interpreter='/home/hushenhua/miniconda3/envs/tf2/bin/python'
let g:ycm_path_to_python_interpreter='/home/hushenhua/miniconda3/envs/face/bin/python'
"是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项"
let g:ycm_cache_omnifunc=0
"字符串中也开启补全"
let g:ycm_complete_in_strings = 1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"显示函数原型
let g:ycm_add_preview_to_completeopt = 1
" YCM自动语义补全
" let g:ycm_semantic_triggers =  {
"             \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"             \ 'cs,lua,javascript': ['re!\w{2}'],
"             \ }
" 补全窗口配色
highlight PMenu ctermfg=black ctermbg=3 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=black ctermbg=white guifg=darkgrey guibg=white
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
" require flake8
Plugin 'w0rp/ale'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_python_flake8_options='--ignore=E501'
" remove left white column
set signcolumn=no
"
Plugin 'tpope/vim-commentary'
noremap <C-l> :Commentary<cr>

Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/star-search'

" Track the engine.
Plugin 'SirVer/ultisnips'
" " Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion=3

"Plugin 'davidhalter/jedi-vim'
"let g:jedi#popup_on_dot=0
"
"Plugin 'jiangmiao/auto-pairs'
"
"Plugin 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = "context"
"
call vundle#end()            " required



" 配色方案
" set background=dark
" colorscheme solarized
" colorscheme molokai
" colorscheme phd
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
" 基于缩进或语法进行代码折叠
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
noremap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" 过滤: 所有指定文件和文件夹不显示
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']  

"###################    set file head start  #########################
"autocmd创建新文件自动调用setfilehead()函数
autocmd BufNewFile *.py exec ":call Setfilehead()"
func Setfilehead()
    call append(0, '#!/usr/bin/env python')
    call append(1, '# -*- coding:utf-8 -*-')
    call append(2, '# Filename      : '.expand("%"))
    call append(3, '# Author        : Shenhua.Hu - hushenhua2017@ia.ac.cn')
    call append(4, '# Laboratory    : High-Speed-Vision Lab')
    call append(5, '# School        : Institute of Automation, Chinese Academy of Sciences')
    call append(6, '# Create        : '.strftime("%Y-%m-%d %H:%M:%S"))
    call append(7, '')
endfunc

"map F2 to creat file head comment
"映射F2快捷键，生成后跳转至第10行，然后使用o进入vim的插入模式
map <F2> :call Setfilehead()<CR>
"###################    set file head end   ##########################
