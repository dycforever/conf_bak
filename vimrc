" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
"set t_Co=256
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,latin1
set fileencoding=utf-8
set termencoding=utf-8


"===================plugin ========================
set completeopt=longest,menu 
set cscopequickfix=s-,c0,d-,i-,t-,e-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

"    " show msg when any other cscope db added
"    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@><C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@><C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@><C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@><C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@><C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@><C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-f>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-f>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-f>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


" ============== using vim bundle =================
"

" 0-bundle the plugins
"package dependent:  ctags
"python dependent:  pep8, pyflake

set nocompatible
filetype off " required! turn off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" use vundle to manage vundle
Plugin 'gmarik/vundle'
" vim plugin bundle control, command model
" :BundleInstall     install
" :BundleInstall!    update
" :BundleClean       remove plugin not in list
" ============== using vim bundle =================

Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/taglist.vim'
"Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'grep.vim'
Plugin 'a.vim'
Plugin 'winmanager'
Plugin 'bufexplorer.zip'
Plugin 'vim-scripts/Conque-Shell'

""Plugin 'vim-scripts/Conque-GDB'
""Plugin 'css_color.vim'
Plugin 'pangloss/vim-javascript'
""Plugin 'mattn/emmet-vim'

" remove for conflict with conque-gdb
"Plugin 'mark'

"emmet only enable normal mode functions."
let g:user_emmet_mode='n'

call vundle#end()
filetype plugin indent on

let mapleader=','

nmap wm :WMToggle<CR>

nnoremap <silent> <F1> :ConqueTermVSplit bash<CR>
nnoremap <silent> <F5> :BufExplorerVerticalSplit<CR>
nnoremap <silent> <F6> :Rgrep<CR>

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

let g:tagbar_left = 1
let g:tagbar_autoshowtag = 1

let g:NERDTree_title='NERD Tree'  
let g:winManagerWindowLayout='NERDTree|TagList'  

function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction  
      
function! NERDTree_IsValid()  
    return 1  
endfunction 

"remap tab operation
"
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <C-l> :tabn<cr>
map <C-h> :tabp<cr>


""let g:ycm_global_ycm_extra_conf ='/home/dinyc/.vim/.ycm_extra_conf.py'
""" disable ycm 
let g:ycm_auto_trigger=1
""" don't ask before loading
let g:ycm_confirm_extra_conf=0
""jump to the definition of function 
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap <leader>sv :source $MYVIMRC<cr>


"=========dyc add=========
set scrolloff=5
if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
endif
set cursorline

" Fix Cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set noendofline binary

set title 
set novisualbell           " don't beep
set noerrorbells         " don't beep
"set ignorecase 		 " ignore case in search


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai	

set laststatus=2
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set statusline=%f\ %h%m%r

syntax enable
set number
set shiftwidth=2
set tabstop=2
set ts=2
set expandtab
set background=dark
"colorscheme solarized
colorscheme torte
"set foldmethod=syntax
function! CHANGE_CURR_DIR()
	let _dir=expand("%:p:h")
	exec "cd " . _dir
	unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

" 自动括号补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i

set runtimepath^=~/.vim/bundle/ctrlp.vim

set wildmenu
set wildmode=longest:list

"" show tab and whitespace in vim
"set list listchars=tab:→\ ,trail:·
"
" TODO install ack.vim/NERDTree/BufferExplorer
"
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
let g:go_fmt_autosave = 0
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)))
 
au FileType go nmap <Leader>e <Plug>(go-rename)


""let g:javascript_conceal_function   = "ƒ"
""let g:javascript_conceal_null       = "ø"
""let g:javascript_conceal_this       = "@"
""let g:javascript_conceal_return     = "⇚"
""let g:javascript_conceal_undefined  = "¿"
""let g:javascript_conceal_NaN        = "ℕ"
""let g:javascript_conceal_prototype  = "¶"
""let g:javascript_conceal_static     = "•"
""let g:javascript_conceal_super      = "Ω"
