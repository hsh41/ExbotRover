set nocompatible              " required
filetype off                  " required
set backspace=indent,eol,start
"set background=dark
syntax on
filetype plugin indent on
set ic
set hlsearch
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,GB2312,big5
set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=yellow
hi CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=yellow
set autoindent
set smartindent
set scrolloff=4
set tabstop=4
set expandtab
set showmatch
set nu
let python_highlight_all=1
vnoremap // y/<c-r>"<cr>
"让vim记忆上次编辑的位置
autocmd BufReadPost *
			\ if line("'\"")>0&&line("'\"")<=line("$") |
			\	exe "normal g'\"" |
			\ endif

set softtabstop=4
set shiftwidth=4
au Filetype python set textwidth=120
set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
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
		exec "!time python3 %"
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
Plugin 'Chiel92/vim-autoformat'
nnoremap <F3> :Autoformat<CR>
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
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
Plugin 'https://github.com/bling/vim-airline'
"
Plugin 'Valloric/YouCompleteMe'
"默认配置文件路径"
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
"python解释器路径"
"let g:ycm_path_to_python_interpreter='/home/users/shenhua.hu/miniconda3/envs/prediction/bin/python'
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
"回车即选中当前项"
"inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'
" 上下左右键行为"
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'
"显示函数原型
let g:ycm_add_preview_to_completeopt = 1
"
Plugin 'w0rp/ale'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_python_flake8_options='--ignore=E501'
"
Plugin 'tpope/vim-commentary'
noremap <C-l> :Commentary<cr>
"Plugin 'flazz/vim-colorschemes'
"set t_Co=256
"colorscheme solarized
"Plugin 'davidhalter/jedi-vim'
"let g:jedi#popup_on_dot=0
"
"Plugin 'jiangmiao/auto-pairs'
"
"Plugin 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = "context"
"
" " Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)
"
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
