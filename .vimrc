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
highlight CursorLine   cterm=NONE ctermbg=red ctermfg=NONE guibg=NONE guifg=NONE
set cursorcolumn
highlight CursorColumn   cterm=NONE ctermbg=green ctermfg=NONE guibg=NONE guifg=NONE
set hls
highlight Search term=reverse ctermbg=4 ctermfg=7
highlight visual term=reverse ctermbg=11 ctermfg=7

set incsearch
set wrapscan

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set statusline=%{&ff}\|%{&fenc!=''?&fenc:&enc}\|%y\|c:%v\,r:%l\ of\ %L\|%f

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

Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim', { 'on':  'TlistToggle' }
Plug 'vim-scripts/OmniCppComplete'
Plug 'kshenoy/vim-signature'
"Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
"Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()


" ---------------------------------------- plugs config ----------------------------------------"

" -------------------- nerdtree -------------------- "

map <C-n> : NERDTree<CR>

" -------------------- taglist -------------------- "

let Tlist_Show_One_File=1    " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
let Tlist_Sort_Type="name"   " tag按名字排序
map <C-l> : TlistToggle<CR>

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

set tags+=~/.vim/tags/cpp_src/tags
set tags+=/usr/include/c++/tags
set tags+=~/work/skyguard/internal/include/tags

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
"set tags+=~/.vim/tags/cpp_src/tags
"set tags+=/usr/include/c++/tags
"set tags+=~/work/skyguard/internal/include/tags

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
