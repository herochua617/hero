"====[ gergap's Vim Configuration ]======================================
" VIM configuration
" change this to your needs
"========================================================================

"====[ some basic editor settings ]======================================


set tabstop=2       " if there are tabs display them with 4 spaces
set shiftwidth=2    " intend with 4 spaces
set expandtab       " always use 4 spaces instead of tabs
set list           " enable looking whitespace
noremap <F2> :set invlist<CR>
set softtabstop=4   " this way backspace will remove the 'virtual' tab
set backspace=2     " make backspace working as expected
set lcs=eol:@,tab:>-,trail:~,nbsp:-            "set whitespaces
set clipboard+=unnamedplus
set autochdir
set paste
set go+=a
set statusline+=%F

"allow elimination of trailing whitespaces
noremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR> 

"allow elimination of tabs
map <F1> ::%s/\t/  /g<CR>


" intend wrapped text and show the ">" symbol. The three spaces intend
" the text, which often fits text that I write.
"exec "set showbreak=\u21AA\\ \\ \\ "
"set UTF-8 encoding
"set enc=utf-8
"set fenc=utf-8
"set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" enable cindent
set cindent
set cinoptions+=:0,g0
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=119 |
    \ set noexpandtab   |
    \ set autoindent    |

" enable line numbers
set number
set cursorline

"show current position
set ruler

"set the command bar to 2 bars
set cmdheight=2

"a buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" enable syntax highlighting
syntax off

" Always show at least one line above and below cursor
if !&scrolloff
    set scrolloff=1
endif

" The same for side scrolling
if !&sidescrolloff
    set sidescrolloff=5
endif

" See :h 'display' for an explanation of this
set display+=lastline

"enable filetype
filetype plugin indent on


"color setting for selected tab
"foreground: LightGray, background: DarkMagenta
"":hi for details
"highlight TabLineSel ctermfg=7 ctermbg=5
"
"" Set extra options when running in GUI mode
if has("gui_running")
set guioptions-=T
set guioptions+=e
set guitablabel=%M\ %t
endif

" font selection
if has("win32")
    " Notes on Windows: You need to install gvim74.exe, python2.7.8 and ctags.
    " ctags zip contains a pre-built ctags.exe. Just put it into next to
    " gvim.exe, so it will be found.
    set gfn=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
    " disable clang_complete on Windows
    let g:clang_complete_loaded = 1
elseif has("gui_running")
" Makes search act like search in modern browsers
set incsearch

elseif has("gui_running")
set lazyredraw

elseif has("gui_running")
set magic

elseif has("gui_running")
set showmatch

elseif has("gui_running")
set mat=2elseif has("gui_running")
    " gvim
    set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ Bold\ 12
else
    " console vim in 256 color terminal
    set t_Co=256
endif
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden
" configur external text formatter
"set formatprg=par-format\ -w78
"enable mouse scroll
set mouse=a
" turn off swap files
set noswapfile
" case insensitive search if all lowercase
set ignorecase smartcase
" disable clang_complete
"let g:clang_complete_loaded = 1

" Highlight search results
set hlsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

call plug#begin('~/.vim/plugged')
Plug 'nightsense/strawberry'
call plug#end()

"=====[ enable pathogen vim package manager ]============================
execute pathogen#infect()
Helptags

set term=xterm-256color
" configure colorscheme
syntax enable
"colorscheme wombat256
colorscheme gergap
"colorscheme noctu
"colorscheme jelybeans
"colorscheme solarized
"colorscheme badwolf
"colorscheme strawberry-light
"let g:solarized_termcolors=256
set background=dark

"=====[ enable solarized colorscheme        ]============================
" colorscheme solarized
nnoremap <leader><F12> :call <sid>togglebackground()<cr>
function! s:togglebackground()
    if &background == "light"
        let &background = "dark"
    else
        let &background = "light"
    endif
endfunction

"====[ C-Support  ]======================================================
let  g:C_UseTool_cmake    = 'yes' 
let  g:C_UseTool_doxygen = 'yes' 

"====[ map leader ]======================================================
let mapleader=","
let g:mapleader=","

"====[ make edit vim config easys ]======================================
nnoremap <leader>ev :split $MYVIMRC<cr>
" auto reload when config has changed
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"====[ make naughty characters visible ]=================================
"exec "set listchars=tab:\u25B6\\ ,trail:\uB7,nbsp:~"
"set list

set nolist

"====[ enable higlight search ]==========================================
set incsearch
set hlsearch
" This rewires n and N to do the highlighting...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>
" clear last search to remove all highlightings
nnoremap <leader>c :let @/ = ""<cr>

" this makes the current selected word better visible
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
endfunction

"====[ surround word with quotes ]=======================================
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"====[ map Y to y$ ]=====================================================
" from the help: If you like "Y" to work from the cursor to the end of line
" (which is more logical, but not Vi-compatible) use ":map Y y$".
:nnoremap Y y$

"====[ comment out current line ]========================================
"augroup Comment
"    autocmd!
"    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
"    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
"augroup END


"=====[ Make arrow keys move visual blocks around ]======================
"runtime plugin/dragvisuals.vim

"vmap  <expr>  <LEFT>   DVB_Drag('left')
"vmap  <expr>  <RIGHT>  DVB_Drag('right')
"vmap  <expr>  <DOWN>   DVB_Drag('down')
"vmap  <expr>  <UP>     DVB_Drag('up')
"vmap  <expr>  D        DVB_Duplicate()
"vmap  <expr>  <C-D>    DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
"let g:DVB_TrimWS = 1

"=====[ tabularize plugin ]==============================================
"if exists(":Tabularize")
if 1
    nnoremap <leader>a= :Tabularize /=<cr>
    vnoremap <leader>a= :Tabularize /=<cr>
    nnoremap <leader>a: :Tabularize /:\zs<cr>
    vnoremap <leader>a: :Tabularize /:\zs=<cr>
    nnoremap <leader>a& :Tabularize /&<cr>
    vnoremap <leader>a& :Tabularize /&<cr>
else
    echom "Tabularize not available"
endif

" automatically invoke s:align when | is typed
inoremap <bar> <bar><esc>:call <sid>align()<cr>a
" automatically indend latex tabular envireonments
augroup MyLaTeX
    autocmd!
    autocmd FileType tex inoremap <buffer> & &<esc>:call <sid>align_tabular()<cr>a
augroup END

" tabularize | helper function
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize')
    if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  else
    echom "no tabularize"
  endif
endfunction

" tabularize latex tabular helper
" this is the same idea as above, but for & instead of |
function! s:align_tabular()
  let p = '^.*&.*&*$'
  if exists(':Tabularize')
    if getline('.') =~# '^[^&]*&' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^&]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*&\s*\zs.*'))
        echom position
        Tabularize/&/l1
        normal! 0
        call search(repeat('[^&]*&',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  else
    echom "no tabularize"
  endif
endfunction

"====[ learn hjkl the hard way ;-) ]=====================================
"nmap <Left> <Nop>
"nmap <Right> <Nop>
"nmap <Up> <Nop>
"nmap <Down> <Nop>

"====[ map :Q to :q ]====================================================
" It happens so often that I type :Q instead of :q that it makes sense to make
" :Q just working. :Q is not used anyway by vim.
command! Q q

"====[ ShowMarks plugin ]================================================
" reduce shows marks to I need. The default is
"let s:all_marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""
let g:showmarks_include="abcdefghijklmnopqrstuvwxyz.[]<>"

"====[ superTab plugin ]=================================================
" uncomment the next line to disable superTab
"let loaded_supertab = 1
"set completeopt=menu,longest
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabLongestHighlight=1
"let g:SuperTabLongestEnhanced=1

"====[ Taglist plugin ]==================================================
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1

"====[ airline ]=========================================================
" use powerline fonts to show beautiful symbols
let g:airline_powerline_fonts = 1
" enable tab bar with buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#loclist#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy "
" fix the timout when leaving insert mode (see
" http://usevim.com/2013/07/24/powerline-escape-fix)
if ! has('gui_running')
  set ttimeoutlen=100
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

"====[ fugitive vim plugin ]=============================================
set laststatus=2
"set statusline=%{GitBranch()}

"====[ DoxygenToolKit ]==================================================
" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
let g:DoxygenToolkit_startCommentTag = "/**"
let g:DoxygenToolkit_startCommentBlock = "/*"
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Eng Seng (mqn486)"
"let g:DoxygenToolkit_licenseTag="My own license"
"let g:DoxygenToolkit_interCommentTag = "* "

"====[ make use of F-keys ]==============================================
" unindent with Shift-Tab
imap <S-Tab> <C-o><<
" use F2 for saving
"nnoremap <F2> :w<cr>
"inoremap <F2> <esc>:w<cr>i
"nmap <script> <silent> <F2> :call ToggleQuickFix()<CR>
"map <F3> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"inoremap <F3> <C-O>:set invnumber<CR>
" map F3 and SHIFT-F3 to toggle spell checking
"nmap <F3> :setlocal spell spelllang=en<CR>
"imap <F3> <ESC>:setlocal spell spelllang=en<CR>i
"nmap <S-F3> :setlocal nospell<CR>
"imap <S-F3> <ESC>:setlocal nospell<CR>i
map <F3> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
" switch between header/source with F4 in C/C++ using a.vim
nmap <F4> :A<CR>
imap <F4> <ESC>:A<CR>i
" currently S-F4 does not work in KDE konsole. Don't know why.
" nmap <S-F4> :AV<CR>
" imap <S-F4> <ESC>:AV<CR>i
" recreate tags file with F5
"map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set pastetoggle=<F5>
" create doxygen comment
map <F6> :Dox<CR>
"nnoremap <F7>  :TlistToggle<CR>
nnoremap <F7>  :TagbarToggle<CR>
" clean build using makeprg with <S-F7>
"map <S-F7> :make clean all<CR>
" Simple hexify/unhexify
"noremap <F8> :call <sid>Hexify()<CR>
nnoremap <F8> :set invnumber<CR>:ShowMarksToggle<CR>:GitGutterSignsDisable<CR>:SyntasticReset<CR>
nnoremap <F9> :call QFixToggle()<CR>
" Apply YCM FixIt
"map <F9> :YcmCompleter FixIt<CR>
" remove trailing spaces
map <F10> :%s/\s\+$//<CR>
" run kdbg
"nmap <leader>d :call ExecuteKDbg()<CR>
"nmap <leader>x :call RunTarget()<CR>
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" prefer vertical diff
set diffopt+=vertical
" in diff mode we use the spell check keys for merging
nnoremap <expr> <M-Down>  &diff ? ']c' : &spell ? ']s' : ':cn<cr>'
nnoremap <expr> <M-Up>    &diff ? '[c' : &spell ? '[s' : ':cp<cr>'
nnoremap <expr> <M-Left>  &diff ? 'do' : ':bp<cr>'
nnoremap <expr> <M-Right> &diff ? 'dp' : ':bn<cr>'
" spell settings
"  :setlocal spell spelllang=en
" set the spellfile - folders must exist
" global wordlist, press zg to add a word to the list
set spellfile=~/.vim/spellfile.add
" project specific ignore list, press 2zg to add a word to this ignore list
set spellfile+=ignore.utf-8.add

"====[ copy paste            ]===========================================
vnoremap <C-c> "ay<ESC>
nnoremap <leader><C-p> "ap
nnoremap <leader><C-c> viw"ay<ESC>

"====[ Ctrl-P plugin         ]===========================================
nnoremap <leader>t :CtrlPTag<cr>

"====[ NERDTree plugin       ]===========================================
nnoremap <leader>n :NERDTreeToggle<cr>
let g:NERDTreeDirArrows=0
let g:NERDTreeDirArrowExpandable = '.'
let g:NERDTreeDirArrowCollapsible = '.'

"====[ indentLines plugin    ]===========================================
let g:indentLine_enabled = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'

"====[ resize split windows ]============================================
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"====[ Cscope ]==========================================================
if has("cscope")

set csprg=cscope
set csto=0
set cst
set nocsverb
set csverb

let GtagsCscope_Auto_Load = 1
let GtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
let GtagsCscope_Absolute_Path = 1
let cwd = fnamemodify('.',':p')
set cscopetag
set cscopeverbose 
"set cscopequickfix=s-,c-,d-,i-,t-,e-

    if (matchstr(cwd,'tetra1') == 'tetra1') 
       if filereadable("/data/mqn486/DB/tetra.cscope")
       set tag+=/data/mqn486/DB/tetra.ctags
           cs add /data/mqn486/DB/tetra.cscope
       endif
		   echo "tetra1 directory"
		elseif (matchstr(cwd, 'tetra2') == 'tetra2')
       if filereadable("/data/mqn486/DB/tetra2.cscope")
       set tag+=/data/mqn486/DB/tetra2.ctags
           cs add /data/mqn486/DB/tetra2.cscope
       endif
		   echo "tetra2 directory"
    elseif (matchstr(cwd, 'tetra_1') == 'tetra_1')
       if filereadable ("/data/mqn486/DB/tetra_1.cscope")
			 set tag+=/data/mqn486/DB/tetra_1.ctags
			     cs add /data/mqn486/DB/tetra_1.cscope
			 endif
		   echo "tetra_1 directory"
    elseif (matchstr(cwd, 'tetra_2') == 'tetra_2')
       if filereadable ("/data/mqn486/DB/tetra_2.cscope")
			 set tag+=/data/mqn486/DB/tetra_2.ctags
			     cs add /data/mqn486/DB/tetra_2.cscope
			 endif
		   echo "tetra_2 directory"
	  endif


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

    "add any cscope database in current directory
    if filereadable("cscope.out")
    "    cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

nmap <C-\>s :tab cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>g :tab cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :tab cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>t :tab cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>e :tab cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>f :tab cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-\>i :tab cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :tab cs find d <C-R>=expand("<cword>")<CR><CR> 



 nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>    
 nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>    
 nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>    
 nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>    
 nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>    
 nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>    
 nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>  
 nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>   

 nmap <C-@><C-@>s:vert scs find s <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
 nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>    
 nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>  
 nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

 set timeoutlen=4000

endif "if has("cscope")

"====[ OnmniCppComplete ] ===============================================
"set nocp  
"filetype plugin indent on
set omnifunc=gtagsomnicomplete#Complete

" set statusline+=%#warningmsg#                   
" set statusline+=%{SyntasticStatuslineFlag()}    
" set statusline+=%*                              
" let g:syntastic_always_populate_loc_list = 0    
" let g:syntastic_auto_loc_list = 0               
" let g:syntastic_check_on_open = 1               
" let g:syntastic_check_on_wq = 0                 
" let g:syntastic_error_symbol = 'X'              
" let g:syntastic_warning_symbol = '!'            

"====[ vim-tmux-navigator ]==============================================
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-k> :TmuxNavigateDown<cr>
nnoremap <silent> <c-j> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"====[ add convenience function for underlining text ]===================
" this is useful for markdown headers level 1 and 2
function! Header1()
    normal yypv$r=
endfunction
function! Header2()
    normal yypv$r-
endfunction
nnoremap <silent> <Leader>U :call Header1()<CR>
nnoremap <silent> <Leader>u :call Header2()<CR>

"====[ hexify/unhexify using Vim's built-in xxd commend ]================
function! s:Hexify()
    " we need to ensure that Vim doesn't add garbage to the binary file
    set binary "use binary mode
    set noeol  "disable adding EOL
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunc
function! EscapeText(text)

    let l:escaped_text = a:text

    " Map characters to named C backslash escapes. Normally, single-quoted
    " strings don't require double-backslashing, but these are necessary
    " to make the substitute() call below work properly.
    "
    let l:charmap = {
    \   '"'     : '\\"',
    \   "'"     : '\\''',
    \   "\n"    : '\\n',
    \   "\r"    : '\\r',
    \   "\b"    : '\\b',
    \   "\t"    : '\\t',
    \   "\x07"  : '\\a',
    \   "\x0B"  : '\\v',
    \   "\f"    : '\\f',
    \   }

    " Escape any existing backslashes in the text first, before
    " generating new ones. (Vim dictionaries iterate in arbitrary order,
    " so this step can't be combined with the items() loop below.)
    "
    let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')

    " Replace actual returns, newlines, tabs, etc., with their escaped
    " representations.
    "
    for [original, escaped] in items(charmap)
        let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
    endfor

    " Replace any other character that isn't a letter, number,
    " punctuation, or space with a 3-digit octal escape sequence. (Octal
    " is used instead of hex, since octal escapes terminate after 3
    " digits. C allows hex escapes of any length, so it's possible for
    " them to run up against subsequent characters that might be valid
    " hex digits.)
    "
    let l:escaped_text = substitute(l:escaped_text,
    \   '\([^[:alnum:][:punct:] ]\)',
    \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
    \   'g')

    return l:escaped_text

endfunction

    " adding search for text in visual mode
    vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'")

function! PasteEscapedRegister(where)

    " Remember current register name, contents, and type,
    " so they can be restored once we're done.
    "
    let l:save_reg_name     = v:register
    let l:save_reg_contents = getreg(l:save_reg_name, 1)
    let l:save_reg_type     = getregtype(l:save_reg_name)

    echo "register: [" . l:save_reg_name . "] type: [" . l:save_reg_type . "]"

    " Replace the contents of the register with the escaped text, and set the
    " type to characterwise (so pasting into an existing double-quoted string,
    " for example, will work as expected).
    "
    call setreg(l:save_reg_name, EscapeText(getreg(l:save_reg_name)), "c")

    " Build the appropriate normal-mode paste command.
    "
    let l:cmd = 'normal "' . l:save_reg_name . (a:where == "before" ? "P" : "p")

    " Insert the escaped register contents.
    "
    exec l:cmd

    " Restore the register to its original value and type.
    "
    call setreg(l:save_reg_name, l:save_reg_contents, l:save_reg_type)

endfunction
" Define keymaps to paste escaped text before or after the cursor.
"
nmap <Leader>P :call PasteEscapedRegister("before")<cr>
nmap <Leader>p :call PasteEscapedRegister("after")<cr>

" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Syntax highlight debugging: this function is from the Vim Manual
function! ShowSyntaxStack()
    for id in synstack(line("."), col("."))
        echo synIDattr(id, "name")
    endfor
endfunction
map <leader>s :call ShowSyntaxStack()<cr>

function! UpdateTags()
  let f = expand("%:p")
  let cmd = 'global --single-update ' . f
  let resp = system(cmd)
  echo "Update " f " done!"
endfunction

function! s:FilterQuickfixList(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . " a:pattern"))
endfunction
command! -bang -nargs=1 -complete=file QFilter call s:FilterQuickfixList(<bang>0, <q-args>)

function! ToggleQuickFix()
  if exists("g:qwindow")
    lclose
    unlet g:qwindow
  else
    try
      lopen 10
      let g:qwindow = 1
    catch 
      echo "No Errors found!"
    endtry
  endif
endfunction
    
let g:QFixToggle_show = 0

function! QFixToggle()
  if g:QFixToggle_show == 1 
    cclose
    let g:QFixToggle_show = 0
  else
    copen 
    let g:QFixToggle_show = 1
  endif
endfunction

function! ExpandCMacro()
  "get current info
  let l:macro_file_name = "__macroexpand__" . tabpagenr()
  let l:file_row = line(".")
  let l:file_name = expand("%")
  let l:file_window = winnr()
  "create mark
  execute "normal! Oint " . l:macro_file_name . ";"
  execute "w"
  "open tiny window ... check if we have already an open buffer for macro
  if bufwinnr( l:macro_file_name ) != -1
    execute bufwinnr( l:macro_file_name) . "wincmd w"
    setlocal modifiable
    execute "normal! ggdG"
  else
    execute "bot 10split " . l:macro_file_name
    execute "setlocal filetype=cpp"
    execute "setlocal buftype=nofile"
    nnoremap <buffer> q :q!<CR>
  endif
  "read file with gcc
  silent! execute "r!gcc -E " . l:file_name
  "keep specific macro line
  execute "normal! ggV/int " . l:macro_file_name . ";$\<CR>d"
  execute "normal! jdG"
  "indent
  execute "%!indent -st -kr"
  execute "normal! gg=G"
  "resize window
  execute "normal! G"
  let l:macro_end_row = line(".")
  execute "resize " . l:macro_end_row
  execute "normal! gg"
  "no modifiable
  setlocal nomodifiable
  "return to origin place
  execute l:file_window . "wincmd w"
  execute l:file_row
  execute "normal!u"
  execute "w"
  "highlight origin line
  let @/ = getline('.')
endfunction

function! Enum2Array()
    exe "normal! :'<,'>g/^\\s*$/d\n"
    exe "normal! :'<,'>s/\\(\\s*\\)\\([[:alnum:]_]*\\).*/\\1[\\2] = \"\\2\",/\n"
    normal `>
    exe "normal a\n};\n"
    normal `<
    exe "normal iconst char *[] =\n{\n"
    exe ":'<,'>normal ==" " try some indentation
    normal `< " set the cursor at the top
endfunction

autocmd FileType cpp nnoremap <leader>m :call ExpandCMacro()<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
