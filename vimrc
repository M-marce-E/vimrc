" My Personal .vimrc File
" Author: Marcelo E Mellimaci
" https://github.com/M-marce-E
"
" To create your vimrc, start up Vim and do one of the following:
"     :e $HOME/.vimrc  " on Unix, Mac or OS/2
"     :e $HOME/_vimrc  " on Windows
"     :e s:.vimrc      " on Amiga
"--------------------------------------------------------------

"This must be first, because it changes other options as a side effect
set nocompatible

"Set VIM's default encoding to UTF-8
set encoding=utf8

"Make backspace behave in a sane manner
set backspace=indent,eol,start

"Show line numbers
set nu

"Enable 256 colors support
let g:onedark_termcolors=256

"Switch syntax highlighting on
syntax on

"Enable file type detection and do language-dependent indenting
filetype plugin indent on

"Highlight the current line in every window and update the highlight as the cursor moves
set cursorline

"Configure color scheme
colorscheme koehler 

"Highlight 81st column, no text should sit on this line. Pretty neat
set colorcolumn=81

"Permanently display the path of the current file
set laststatus=2

"The text look like it has been wrapped at the edge of the screen, when in reality it’s just one long line. This is pretty obvious when line numbers are turned on since there're multiple lines but the number to the left doesn’t increase
set wrap 

"Use Unix as the standard file type
set ffs=unix,dos,mac

"Use colors that look good on a dark background
set background=dark

"The ruler is displayed on the right side of the status line at the bottom, it displays the line number, the column number, the virtual column number, and the relative position of the cursor in the file (as a percentage)
set ruler

"To show incomplete commands
set showcmd

"Show file in titlebar
set title

"Sets indent size of tabs
set tabstop=4

"Soft tabs
set softtabstop=4

"Turns tabs into spaces
set expandtab 

"Sets auto-indent size
set shiftwidth=4

"Turns on auto-indenting
set autoindent

"Copy the previous indentation on autoindenting
set copyindent

"Remembers previous indent when creating new lines
set smartindent 

"Insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab

"Highlights search terms
set hlsearch 

"Highlights search terms as you type them
set incsearch 

"Highlights matching parentheses
set showmatch 

"Ignores case when searching
set ignorecase 

"Unless you put some caps in your search term
set smartcase

"A better menu in command mode
set wildmenu

"Spacebar to hide portions of code that you’re not currently working on
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

"Executing :GitDiff shows the diff before each save, git supports the following command
command GitDiff execute  "w !git diff --no-index -- % -"

"Type ,cc to comment a line and ,cu to uncomment a line (both in normal and visual mode)
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"Press gcc to go to the beginning of the line and insert /* & then go to the end of the line and insert */ 
nnoremap gcc I/* <ESC>A */<ESC>

"To show current function name in C programs you need the f key
fun! ShowFuncName()
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
    echohl None
endfun
map f :call ShowFuncName() <CR>

"Map <Ctrl+L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

"Cut/Copy/Paste use the standard hotkeys, but you don't change any of the other configuration options in GVim
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

"Map Y to act like D and C, eg: to yank until EOL, rather than act as yy, which is the default
map Y y$

"The following mapping causes g~ to 'Title Case' selected text
vnoremap g~ "tc<C-r>=substitute(@t, '\v<(.)(\S*)', '\u\1\L\2', 'g')<CR><Esc>

"Press Tab or Shift-Tab to adjust the indent on selected lines
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"Pressing F2 will toggle line numbering
map <silent> <F2> :set invnumber<cr>
"To prevent Vim from inserting function key names literally when in insert mode
:map! <F2> <Nop>

"When you paste text into a terminal Vim, it can't know it is coming from a paste. It is like text entered fast (key strokes), it applies all auto-indenting and auto-expansion of defined abbreviations to the input, resulting in often cascading indents of paragraphs. To prevent this F3 temporarily switch to paste mode 
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode
"To prevent Vim from inserting function key names literally when in insert mode
:map! <F3> <Nop>

"Press F5 to enable the syntax and highlighting for the C language
:nnoremap <F5> :so $VIMRUNTIME/syntax/c.vim <CR>
"To prevent Vim from inserting function key names literally when in insert mode
:map! <F5> <Nop>

"Press F9 to execute the current buffer with python
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
