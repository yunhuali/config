call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'deoplete-plugins/deoplete-clang'
Plug 'ajh17/vimcompletesme'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" fzf#install()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/lsp-status.nvim'
" Color scheme
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
" Beauty
Plug 'Lokaltog/vim-powerline'
" C++ STL 
Plug 'octol/vim-cpp-enhanced-highlight'

" block comment
Plug 'preservim/nerdcommenter'
Plug 'Valloric/YouCompleteMe'

"Plug 'liuchengxu/vista.vim'
" vim-airline
" Enhanced statusline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'
" ros
" Plug 'taketwo/vim-ros'
call plug#end()

" Vim预置有很多快捷键，再加上各类插件的快捷键，大量快捷键出现在单层空间中难免引起冲突。
" 为缓解该问题，而引入了前缀键<leader>。
let mapleader = "\<space>"

" nerdcommenter setting
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 配色方案
set background=dark
colorscheme gruvbox
" colorscheme molokai

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
" 符号重命名
nmap <silent> rn <Plug>(coc-rename)
nnoremap <silent> gh :CocCommand clangd.switchSourceHeader<CR>

" https://stackoverflow.com/questions/65415516/how-to-manuallywithout-keybindings-search-a-symbol-in-a-source-code-using-coc
nnoremap <silent><nowait> <Leader>s  :<C-u>CocList -I symbols<cr>

" 关闭兼容模式
set nocompatible
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
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

let g:python3_host_prog = '/usr/bin/python3.8'
let b:deoplete_disable_auto_complete = 1
" source $HOME/.config/nvim/liuchengxu-vista.vim
set nowrap

" edit or reload $MYVIMRC(this config file)
nnoremap <silent> <leader>c :e $MYVIMRC<CR>
nnoremap <silent> <leader>r :source $MYVIMRC<CR>

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>,
\                 <bang>0 ? fzf#vim#with_preview('up:60%')
\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
\                 <bang>0)
