set nocompatible              " be iMproved

call plug#begin()

" custom plugins
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mbbill/undotree'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
"" Great tool for auto-completion of variables and functions
Plug 'Valloric/YouCompleteMe'
"" Good Auto Fill Tool use F2 to trigger
Plug 'SirVer/ultisnips'
"" This plug-in provides automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'
" 可以在導航目錄中看到 git 版本資訊
Plug 'Xuyuanp/nerdtree-git-plugin'
"" C and other languages' formatting
Plug 'Chiel92/vim-autoformat'
"" These two are for mark-down
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
"" Fuzzy Search of files in repository|file directory. Super handy!!
Plug 'kien/ctrlp.vim'

" all of your Plugins must be added before the following line
call plug#end()            " required

" general customizations
syntax on
set ts=4
set sw=4
set number
set cursorline
set scrolloff=10
set encoding=utf-8
colorscheme molokai
" Easier to delete space(tab)
set smarttab
set hlsearch
" do not history when leavy buffer
set hidden
set complete-=i
set showmode
set shiftround
set ttimeout
set ttimeoutlen=50
set incsearch
set ignorecase
set laststatus=2
set ruler
set showcmd
set wildmenu
set noswapfile
set fileformats=unix,dos,mac

set cursorline
set completeopt=menuone,longest,preview

""" Markdown
"let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_math=1

""" CtrlP
let mapleader = 'f'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<cr>'],
	\ 'AcceptSelection("e")': ['<2-LeftMouse>'],
	\ }

" vim go
" disable open browser after posting snippet
let g:go_play_open_browser = 0
" enable goimports
let g:go_fmt_command = "goimports"
" enable additional highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
"" This can prevent the bug when only one tab left
let g:airline#extensions#tabline#show_buffers = 0
"" Show tab number by its sequence
let g:airline#extensions#tabline#tab_nr_type = 1
set statusline=%{GitBranch()}

""" You complete me
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_completion_confirm_key = '<Right>'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"" YCM配置
" 全局YCM配置文件路径
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0  " 不提示是否载入本地ycm_extra_conf文件

" 语法关键字、注释、字符串补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" 从注释、字符串、tag文件中收集用于补全信息
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" 禁止快捷键触发补全
let g:ycm_key_invoke_completion = '<c-space>'  " 主动补全(默认<c-space>)

" 输入2个字符就触发补全
let g:ycm_semantic_triggers = {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
                                    
let g:ycm_show_diagnostics_ui = 0  " 禁用YCM自带语法检查(使用ale)

" 防止YCM和Ultisnips的TAB键冲突，禁止YCM的TAB
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

""" tagbar
let g:tagbar_autofocus=1
let g:tagbar_foldlevel=2
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


""" vim-autoformat
let g:autoformat_autoindent = 0 
let g:autoformat_retab = 0 
let g:autoformat_remove_trailing_spaces = 0
let g:formatterpath = ['/usr/local/go/bin/gofmt', '/usr/local/bin/clang-format', '/usr/local/bin/js-beautify']
nmap == :Autoformat<CR>
autocmd BufEnter *.go* exe 'vmap = :Autoformat<CR>'
autocmd BufEnter *.c* exe 'vmap = :Autoformat<CR>'
autocmd BufEnter *.json* exe 'vmap = :Autoformat<CR>'

"" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F5> :!google-chrome-stable %:p<CR>'

" shortcuts remap
nmap <F2> :tabnew<CR>
nmap <F3> :tabclose<CR>
nmap <F5> :UndotreeToggle<CR>
nmap <F7> :NERDTreeTabsToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>
" Switch btw splitted windows
"nmap <silent> <A-Left> :wincmd w<CR>
"nmap <silent> <A-Right> :wincmd w<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
noremap  <C-E> :q!<CR>
vnoremap <C-E> <C-C>:q!<CR>
inoremap <C-E> <Esc>:q!<CR>
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>
inoremap <C-U> <C-G>u<C-U>

" Ctrl+J跳转至定义、声明或文件
nnoremap <C-J> :YcmCompleter GoToDefinitionElseDeclaration<CR>|

" jump between errors in quickfix list
let mapleader = 'c'
map <leader>n :cnext<CR>
map <leader>m :cprev<CR>
nnoremap <leader>c :cclose<CR>

let mapleader = 'g'
" show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <leader>s <Plug>(go-implements)
" show type info for the word under your cursor
au FileType go nmap <leader>gi <Plug>(go-info)
" open the relevant Godoc for the word under the cursor
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
" run Go commands
au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>i <Plug>(go-install)
" open the definition/declaration in a new vertical, horizontal or tab for the
" word under your cursor
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)
" rename the identifier under the cursor to a new name
au FileType go nmap <leader>e <Plug>(go-rename)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

""" OSC52: Ctrl+c copy to clipboard in vim
source ~/.vim/osc52.vim
vmap <C-c> y:call SendViaOSC52(getreg('"'))<CR>

set virtualedit=onemore
vnoremap $ $h

autocmd FileType make set noexpandtab
