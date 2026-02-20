" Basics "
set nocompatible
filetype plugin indent on
syntax on

" Colorscheme "
colorscheme zellner

" Appearance "
set nu			" print the line number in front of each line
set rnu			" show relative line number in front of each line
set cul			" highlight the screen line of the cursor
set cc=80		" columns to highlight
set ls=2		" tells when last window has status lines 
set ru			" show cursor line and column in the status line
set sc			" show (partial) command somewhere
set sm			" briefly jump to matching bracket if insert one

" Indentation "
set ts=4		" number of spaces that <Tab> in file uses
set sw=4		" number of spaces to use for (auto)indent step
set et			" use spaces when <Tab> is inserted
set si			" smart autoindenting for C programs
set ci			" do C program indenting

" Search "
set is			" highlight match while typing search pattern 
set hls			" highlight matches with last search pattern
set ic			" ignore case in search patterns
set scs			" no ignore case when pattern has uppercase

" Behavior "
set hid			" don't unload buffer when it is |abandon|ed
set nowrap		" (no) long lines wrap and continue on the next line
set so=8		" minimum nr. of lines above and below cursor
set sb			" new window from split is below the current one
set spr			" new window is put right of the current one
set ut=300		" after this many milliseconds flush swap file
set bs=indent,eol,start	" how backspace works at start of line
set cb=unnamedplus	" use the clipboard as the unnamed register

" Wildmenu "
set wmnu		" use menu for command line completion
set wig=*.o,*.a,*.so,*.d,*.out,*.swp,*.bak	" files matching these patterns are not completed

" Backup "
set nobk		" (no) keep backup file after overwriting a file
set noswf		" whether to use a swapfile for a buffer

" Mappings "
let mapleader = " "
" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Navigate buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

" Build & run (adjust as needed)
nnoremap <leader>m :make<CR>
nnoremap <leader>r :!./%<<CR>

" Jump to definition (ctags)
nnoremap <leader>] <C-]>
nnoremap <leader>[ <C-t>

" === C-specific ===
" Auto-close braces
inoremap {<CR> {<CR>}<Esc>O

" Format with clang-format
nnoremap <leader>f :%!clang-format<CR>

" === Netrw (built-in file explorer) ===
let g:netrw_banner    = 0
let g:netrw_liststyle = 3
let g:netrw_winsize   = 25
nnoremap <leader>e :Lexplore<CR>

" === Status Line ===
set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]%=%l/%L\ col:%c\ %p%%
