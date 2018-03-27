
" option
let use_golang=1
let use_neocomplete=1	" 1 use neocomplete, 2 use youcompleteme
let for_fedora=1
let enable_ruby=0

if has('mouse')
	set mouse=a
endif			


set langmenu=none 		"force to use the English manus
"set nocompatible		"be iMproved

filetype off			"required

hi Normal ctermfg=252 ctermbg=none
set t_Co=256

" Setting up NeoBundle --the vim plugin bundler
let neo_bundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neo_bundle_readme)
	echo "Installind NeoBundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
	if &compatible
		set nocompatible	"be iMproved
	endif

	"Required
	set runtimepath^=~/.vim/bundle/neobundle.vim/
endif

" Required
call neobundle#begin(expand('~/.vim/bundle/'))

" let neobundle auto update
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc',{
	\ 'build' :{
	\ 	'windows': 'tools\\update-dll-mingw', 
	\	'cygwin': 'make -f make_cygwin.mak',
	\	'mac': 'make',
	\	'linex': 'make',
	\	'unix': 'gmake'
	\	},
	\}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'rtyler/ctags'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle "garbas/vim-snipmate"
NeoBundle "honza/vim-snippets"
NeoBundle "othree/xml.vim"
NeoBundle "vim-airline/vim-airline-themes"
NeoBundle 'vim-airline/vim-airline'
NeoBundle 't9md/vim-choosewin'
NeoBundle 'chr4/nginx.vim'
if use_golang==1
	NeoBundle 'fatih/vim-go'
endif

if (enable_ruby)
NeoBundle 'tpope/vim-rails'

NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'beaugunderson/vim-scss-instead'
endif

" NerdTree
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
let NERDTreeWinPos='left'
let NERDTreeWinSize=20
let NERDTreeChDirMode=1
let NERDTreeQuitOnOpen=1			" 打开文件时关闭树
let NERDTreeMouseMode=1				" 双击打开文件
map <C-t> :NERDTreeToggle<CR>		" Ctrl+n打开或在隐藏NERDTree
"autocmd vimenter * NERDTree			" 启动vim时自动启动NERDTree
"没有指定文件启动vim时,也启动NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 

" AirLin
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

if (for_fedora!=1)
	let g:airline_theme='behelit'"'base16' 
else
	let g:airline_theme='distinguished'
endif

let g:airline#extensions#fnamemod=':t'
set hidden
nmap <C-k> :bnext<cr>				"nexe buffer
nmap <C-j> :bprev<cr>

"choosewin
let g:choosewin_overlay_enable=1
let g:choosewin_overlay_clear_multibyte=1
let g:choosewin_statusline_replace=0
nmap g- <Plug>(choosewin)

"tagbar
NeoBundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width=25

" languages
NeoBundle 'Mizuchi/STL-Syntax'


" colorscheme
NeoBundle 'w0ng/vim-hybrid'
let g:hybrid_use_Xresources=1

"NeoBundle 'ryanb/dotfiles'

NeoBundle 'jonathanfilip/vim-lucius'
let g:lucius_style='dark' 
let g:lucius_contrast='normal'
let g:lucius_contrast_bg='normal'
let g:lucius_use_bold=1
let g:lucius_use_underline=1
let g:lucius_no_term_bg=1

"Complete
if use_neocomplete==1
	NeoBundle 'Shougo/neocomplete.vim'
endif
if use_neocomplete==2
	NeoBundle 'Valloric/YouCompleteMe'
	NeoBundle 'Valloric/ListToggle'
endif

call neobundle#end()
filetype plugin indent on 	" Required

" If there are uninstalled bundles found on startup
" this will conveniently promt you to install them
NeoBundleCheck
" Setting up NeoBundle -the vim plugin bundler end

" some basic setting
set number			" Show line numbers
"set relativenumber		" Show relative line numbers 
syntax enable			" Turn on syntax highlighting
let mapleader = ","		" The Leader char is ','
set fileencodings=ucs-bom,utf-8,cp936,utf-16
set encoding=utf-8		" Set default encoding to UTF-8
set pastetoggle=<F9>	"切换past模式
set noshowmode 			"otherwise messages shown at the bottom line
set autoread			"当文件在外部被修改时,自动加载
set lazyredraw			"don't redraw while executing macros
set nobackup 
set nowb
set noswapfile 
set cursorline


set foldenable
set foldmethod=syntax
set foldcolumn=0
"set foldclose=all
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Theme Setting
" hybrid 不会修改背景,也就是说可以使背景透明
" lucius 会修改背景色,终端无法设置透明
"colorscheme lucius  "linux
colorscheme murphy "koehler   " win-linux  powershell

if (for_fedora!=1)
	colorscheme murphy
else
	colorscheme lucius
endif

set scrolloff=5
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=e

" Editting setting
set autoindent
set smartindent

" Whitespace
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4

"set list
"set backspace=indent,eol,start
"set listchars="tab:<-->,trail:-"

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <C-h> :noh<cr>

"在普通用户下用管理员权限保存文档
map <leader>sudo :w !sudo tee %

au BufRead,BufNewFile *.scss set filetype=scss.css
autocmd FileType scss set iskeyword+=-
au BufRead,BufNewFile *.kuip set filetype=xml

"snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


" neocomplete
if use_neocomplete==1 
	let g:acp_enableAtStartup=0
	let g:neocomplete#enable_at_startup=1
	let g:neocomplete#enable_smart_case=1
	let g:neocomplete#sources#syntax#min_keyword_length=3

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

	" set autocompletion when CTRL-P or CTRL-N are used.
	" It is also used for whole-line
	" . ... scan the current buffer
	" b ... scan other loaded buffers that are in the buffer list
	" w ... buffers from other windows
	" u ... scan unloaded buffers that are in the buffer list
	" U ... scan buffers that are not in the buffer list
	" ] ... tag completion
	" i ... scan current and included files
	set complete=i,.,b,w,u,U,]

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete	

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
	"let g:neocomplete#cursor_hold_i_time=500
    " Or set this.
    let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
	
	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
 		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	if !exists('g:neocomplete#force_omni_input_patterns')
 		let g:neocomplete#force_omni_input_patterns = {}
	endif
endif

" ycm
if use_neocomplete==2	"youcompleteme needs clang #yum install clang
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
	let g:ycm_error_symbol='>>'
	let g:ycm_warning_symbol='>*'
	nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
	nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
	nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
	nmap <F4> :YcmDiags<CR>

	set completeopt=longest,menu "让vim的不全菜单行为与一般ＩＤＥ一致
	autocm InsertLeave * if pumvisible()==0|pclose|endif "离开插入模式自动关闭预览窗口
	inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
	"上下左右键的行为 会显示其他信息
	inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
	inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
	inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
	inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

	"youcompleteme  默认tab  s-tab 和自动补全冲突
	"let g:ycm_key_list_select_completion=['<c-n>']
	let g:ycm_key_list_select_completion = ['<Down>']
	"let g:ycm_key_list_previous_completion=['<c-p>']
	let g:ycm_key_list_previous_completion = ['<Up>']
	let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

	let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
	let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
	let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
	let g:ycm_seed_identifiers_with_syntax=1	"语法关键字补全
	nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
	"nnoremap <leader>lo :lopen<CR>	'open locationlist
	"nnoremap <leader>lc :lclose<CR>	'close locationlist
	inoremap <leader><leader> <C-x><C-o>
	"在注释输入中
	let g:ycm_complete_in_comments = 1
	"在字符串输入中也能补全
	let g:ycm_complete_in_strings = 1
	"注释和字符串中的文字也会被收入补全
	let g:ycm_collect_identifiers_from_comments_and_strings = 0
	let g:syntastic_always_populate_loc_list = 1

endif
