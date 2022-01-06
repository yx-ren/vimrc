" Setting some decent VIM settings for programming

" ---------------------------------------- default system config ----------------------------------------"
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
"set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set clipboard^=unnamed,unnamedplus
set nu
set tabstop=4
set shiftwidth=4
set expandtab
syntax on                       " turn syntax highlighting on by default
set cursorline
"highlight CursorLine   cterm=NONE ctermbg=blue ctermfg=NONE guibg=NONE guifg=NONE
set cursorcolumn
"highlight CursorColumn   cterm=NONE ctermbg=green ctermfg=NONE guibg=NONE guifg=NONE
set hls
highlight Search term=reverse ctermbg=4 ctermfg=7
"highlight visual term=reverse ctermbg=11 ctermfg=7

set incsearch
set wrapscan

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set term=screen
set encoding=utf-8

set statusline=%{&ff}\|%{&fenc!=''?&fenc:&enc}\|%y\|c:%v\,r:%l\ of\ %L\|%f

set t_Co=256

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "MERGE_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

" ---------------------------------------- plugged config ----------------------------------------"


call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim', { 'on':  'TlistToggle' }
Plug 'vim-scripts/OmniCppComplete'
Plug 'kshenoy/vim-signature'
"Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rking/ag.vim'

"Plug 'ycm-core/YouCompleteMe'

call plug#end()


" ---------------------------------------- plugs config ----------------------------------------"

" -------------------- nerdtree -------------------- "

map <C-n> : NERDTree<CR>

" -------------------- vim-easy-align begin -------------------- "

xmap gb <Plug>(EasyAlign)
nmap gb <Plug>(EasyAlign)

" -------------------- vim-easy-align end -------------------- "

map <C-n> : NERDTree<CR>

" -------------------- nerdtree -------------------- "

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone


let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

"noremap <c-z> <NOP>

" -------------------- taglist -------------------- "

let Tlist_Show_One_File=1    " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
let Tlist_Sort_Type="name"   " tag按名字排序
map <C-l> : TlistToggle<CR>

" -------------------- taglist -------------------- "

" -------------------- kshenoy/vim-signature -------------------- "

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" enable gutentags trace log, default was disabled
"let g:gutentags_trace = 1

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 忽略不相关文件夹
"let g:gutentags_ctags_extra_args += ['--exclude=bazel-*']
let g:gutentags_ctags_extra_args += ['--exclude=build']
let g:gutentags_ctags_extra_args += ['--exclude=deps']

" 忽略不相关文件
let g:gutentags_ctags_extra_args += ['--exclude=*.java']

" -------------------- kshenoy/vim-signature -------------------- "

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" -------------------- OmniCppComplete -------------------- "

set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer   and in included files
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_MayCompleteDot=1        "  打开  . 操作符
let OmniCpp_MayCompleteArrow=1      "打开 -> 操作符
let OmniCpp_MayCompleteScope=1      "打开 :: 操作符
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

set tags=./.tags;,.tags
set tags+=~/.vim/tags/.root/cpp/stl/.tags
set tags+=~/.vim/tags/.root/cpp/include/.tags

" -------------------- other -------------------- "

" ---------------------------------------- end ----------------------------------------"

" -------------------- "

"execute pathogen#infect()
"syntax on
"filetype plugin indent on
"
"map <C-n> : NERDTree<CR>
"
"let Tlist_Show_One_File=1    " 只展示一个文件的taglist
"let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
"let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
"let Tlist_Sort_Type="name"   " tag按名字排序
"map <C-l> : TlistToggle<CR>
"
"filetype plugin indent on
"set completeopt=longest,menu
"let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer   and in included files
"let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
"let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"

"map <c-]> g<c-]>

" -------------------- "

""""""""""""""""""""""""""""""""""""""""""""
" 新建文件时，自动根据扩展名加载模板文件
autocmd! BufNewFile * call LoadTemplate()
fun LoadTemplate()
    "获取扩展名或者类型名
    let ext = expand ("%:e")
    let tpl = expand("~/.vim/tpl/".ext.".tpl")
    if !filereadable(tpl)
        echohl WarningMsg | echo "No template [".tpl."] for .".ext | echohl None
        return
    endif

    "读取模板内容
    silent execute "0r ".tpl
    "指定光标位置
    silent execute "normal G$"
    silent call search("#cursor#", "w")
    silent execute "normal 8x"
    "进入插入模式
    startinsert
endfun
""""""""""""""""""""""""""""""""""""""""""""
