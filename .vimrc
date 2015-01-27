set backspace=2
set tabstop=4
set showmode
set nonumber
"set encoding=japan
set shiftwidth=4
set noshowmatch

set noautoindent
set nosmartindent

"set statusline=%f:<l.%l:c.%c%V>
set statusline=%F\:%l.%c%=%{GetStatusEx()}%m%r%y\
set laststatus=2
highlight statusline   term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=blue

set expandtab
set softtabstop=4

syntax on
"colorscheme darkblue
"colorscheme jellybeans

set hlsearch
set incsearch

"tab 可視化
"set list
"set listchars=trail:~

"各ファイルの対応
autocmd BufNewFile,BufRead *.php set softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.twig set softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.html.twig set syntax=htmldjango
autocmd BufNewFile,BufRead *.html set softtabstop=2 shiftwidth=2 syntax=htmldjango
autocmd BufNewFile,BufRead *.js set softtabstop=2 shiftwidth=2 syntax=htmldjango
autocmd BufNewFile,BufRead *.xml.twig set syntax=xml
autocmd BufNewFile,BufRead *.js.twig set syntax=javascript
autocmd BufNewFile,BufRead *.go set syntax=go noexpandtab

" 行末の空白文字を可視化
"highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#123456
"au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
"au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')

highlight WhitespaceEOL ctermbg=cyan guibg=#ADD8E6
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

" 行頭のTAB文字を可視化
highlight TabString ctermbg=red guibg=red
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

filetype plugin on

"less ファイルsyntax highlight
au BufNewFile,BufRead *.less setf less

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

nmap <c-l>l :tabn<cr>
nmap <c-l><c-l> :tabp<cr>

map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

let g:yanktmp_file = '/home/tetaketa/tmp/yanktmp'

function! GetStatusEx()
        let str = ''
    let str = str . '' . &fileformat . ']'
        if has('multi_byte') && &fileencoding != ''
                let str = '[' . &fileencoding . ':' . str
        endif
        return str
endfunction


" ag.vim
nnoremap <c-w>g :Ag! <cword><CR>

" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


" NeoBundle
if has('vim_starting')
   set nocompatible
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" plugin
NeoBundle 'rking/ag.vim'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'fatih/vim-go'
