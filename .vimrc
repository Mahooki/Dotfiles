""""""""""""""""""
"      VIMRC     "
""""""""""""""""""

" This file isn't compatible with vi.
set nocompatible

" Clear any existing autocommands
if has("autocmd")
    autocmd!
endif

" Determine the operating system once, so we don't have to do it over
" and over again
function! GetOperatingSystem()
    let g:os = {}
    let l:os_types = {}
    let l:os_types.win    = ["win64"]
    let l:os_types.mac    = ["mac", "macunix"]
    let l:os_types.unix   = ["unix"]  " Note that MacVim also identifies as unix
    let l:os_types.other  = ["vms"]
    let l:os_types.all    = l:os_types.win + l:os_types.mac + l:os_types.unix + l:os_types.other

    for g:os.fullname in l:os_types.all
        if has(g:os.fullname)
            break
        endif
    endfor
    let g:os.realname = substitute(system("uname"), "\n", "", "")
    let g:os.name = "other"
    let g:os.is_windows = 0
    let g:os.is_mac = 0
    let g:os.is_unix = 0
    if index(l:os_types.win, g:os.fullname) >= 0
        let g:os.name = "windows"
        let g:os.is_windows = 1
    elseif index(l:os_types.mac, g:os.fullname) >= 0
        let g:os.name = "mac"
        let g:os.is_mac = 1
    elseif index(l:os_types.unix, g:os.fullname) >= 0
        let g:os.name = "unix"
        let g:os.is_unix = 1
    endif
endfunction
call GetOperatingSystem()

function! HasColorScheme(name)
     let pat = "colors/" . a:name . ".vim"
     return !empty(globpath(&runtimepath, pat))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""
"                                               "
"            Vim Plug plugins                   "
"                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 250

" lean & mean status/tabline for vim that's light as air
" https://github.com/bling/vim-airline
Plug 'bling/vim-airline'
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
" '¶' is \u00b6
let g:airline_symbols.linenr = '¶'
" '⎇' is \u2387
let g:airline_symbols.branch = '⎇'
" '✎' is \u270e
"let g:airline_symbols.paste = '✎'
let g:airline_symbols.paste = '[paste]'
" '✘' is \u2708
let g:airline_symbols.readonly = '[✘]'
" 'Ξ' is \u039E
let g:airline_symbols.whitespace = 'Ξ'

" A vim plugin to display the indention levels with thin vertical lines
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" Syntax checking hacks for vim
" https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'

" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

Plug 'tbastos/vim-lua'
Plug 'bronson/vim-trailing-whitespace'    " trailing whitespace
Plug 'tpope/vim-commentary'               " Toggle comment with gcc
Plug 'tpope/vim-unimpaired'               " Allows for use of [e ]e etc...
Plug 'gregsexton/MatchTag'                " Match closing tags for HTML

" Brief help
" :PlugList          - list configured plugins
" :PlugInstall(!)    - install (update) plugins
" :PlugClean(!)      - confirm (or auto-approve) removal of unused plugins
call plug#end()

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""
"                                               "
"     Colorschemes, Fonts, and Window Sizes     "
"                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""
" A list of color schemes to use, in the order you want to use them
let s:schemes = ["gruvbox-material", "solarized", "default"]

" Fonts section.  First, create a list of desired fonts for GUI vims.
let s:fonts = ["Fira Code", "Source Code Pro", "Consolas", "Monospace"]
let s:win_font_size = "h12"
let s:mac_font_size = "h12"
let s:unix_font_size = "h12"

if g:os.is_windows
    " Windows-specific settings
    behave mswin
    source $VIMRUNTIME/mswin.vim
    let s:font_size=s:win_font_size
elseif g:os.is_mac
    " MacVim-specific settings
    let s:font_size=s:mac_font_size
else
    " Unix-specific settings for everthing else.
    let s:font_size=s:unix_font_size
endif

if has("gui_running")
    " The font to use for GVim/MacVim
    let s:gui_fonts = []
    for s:font in s:fonts
        let s:gui_fonts += [s:font . ":" . s:font_size]
    endfor
    "let &guifont = join(s:gui_fonts, ",")
    set guifont=Fira\ Code:h12

    " Turn off the toolbar
    set guioptions-=T
endif

" Set a color scheme, only if it is found in the runtimepath.
for s:scheme in s:schemes
    if HasColorScheme(s:scheme)
        exec "colorscheme " . s:scheme
        break
    endif
endfor

set background=dark
highlight HighlightedyankRegion cterm=reverse gui=reverse
augroup vimrc-highlightedyank
  autocmd ColorScheme gruvbox-material highlight HighlightedyankRegion ctermbg=237 guibg=#41423a
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"            Editor Visual Stylings              "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable line numbering
set number

" Flash the window instead of beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set visualbell

" show matching brackets / parentheses
set showmatch

" show which mode you're currently in.
set showmode

" Disable visual line-wrapping.  This does not prevent hard-wraps.
set nowrap

" Turn syntax highlighting on, if vim supports it
if has("syntax") && (&t_Co > 2 || has("gui_running"))
    syntax on

    " This sets up a 'gutter' line at 76 characters.
    if exists("+colorcolumn")
        set colorcolumn=121
        highlight ColorColumn ctermbg=gray guibg=gray
    endif

    if has("extra_search")
        " Turn on search highlighting
        set hlsearch
        " Map F4 to toggle search highlighting:
        map <silent> <F4> :set hlsearch!<CR>:set hlsearch?<CR>
        imap <silent> <F4> <C-O>:set hlsearch!<CR><C-O>:set hlsearch?<CR>
        " Use Enter in Normal mode to disable highlighing after searching
        nmap <silent> <CR> :nohlsearch<CR>
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"                  Status Line                   "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" use '[RO]' for '[readonly]' to save space in the message line:
set shortmess+=r

if has("cmdline_info")
    " display the current mode and partially-typed commands in the status
    " line:
    set showmode
    set showcmd
    " Always display the current cursor position in the lower right corner
    " of the Vim window.  Note that 'statusline' (below) takes precendence
    " over this option, but if you have a Vim that was not compiled with
    " 'statusline' at least you'll have a ruler...if it was compiled with
    " 'cmdline_info'.
    set ruler
endif

" Set up an informative status line.
if has("statusline") && !(exists("g:loaded_airline") && g:loaded_airline)
    if version >= 700
        set statusline=%-02.2n\ %t\ %y\ %m\ %r\ %L\ lines%=\ %lL,%cC\ \(%P\)
        " Always show the status line
        set laststatus=2
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"                  Indentation                   "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" use four spaces for each step of (auto)indent.
set shiftwidth=2
" hitting <Tab> will insert four spaces instead.
set tabstop=2
set softtabstop=2
" round indent to multiple of shiftwidth.
set shiftround
" use spaces instead of tabs to insert a tab.
set expandtab
" Copy indent from current line when starting a new line.
" Also deletes indents if nothing else is written on the line.
set autoindent

autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype haskell setlocal ts=2 sw=2 sts=2 expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"               Text Formatting                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" don't automatically format 'text' as it is typed; i.e. only do this with
" comments, and reflow at 72 characters:
set formatoptions-=t
set formatoptions+=c
set textwidth=120

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"                    General                     "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" have command-line completion <Tab> (for filenames, help topics, option
" names) first list the available options and complete the longest common
" part, then have further <Tab>s cycle through the possibilities:
set wildmode=longest,full
set wildmenu

" Ignore case when completing file names and directories.
if exists("&wildignorecase")
    set wildignorecase
endif

" Enable the mouse in Visual, Insert, and Command modes
" This can be weird sometimes.
if has("mouse")
    set mouse=vic
endif

" nice terminal mouse behavior
set mouse=a

" Lower the timeout when pressing <Esc>
set timeout timeoutlen=3000 ttimeoutlen=100

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the 'best match so far' as search strings are typed:
set incsearch

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" Encoding-related things
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1,default

    " Change the characters used in list mode to some utf-8 characters,
    " if available.
    set listchars=tab:»·,eol:¬
endif

" Keep the cursor in the same column, if possible, when using C-U and
" C-D, etc.
set nostartofline

" Indicates a fast terminal connection.  More characters will be sent to
" the screen for redrawing, instead of using insert/delete line
" commands.  Improves smoothness of redrawing when there are multiple
" windows and the terminal does not support a scrolling region.
set ttyfast

" Do not redraw screen while executing macros, registers and other
" commands that have not been typed.
set lazyredraw

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=3

" Automatically save the buffer when performing various commands.
set autowrite

" Set the terminal title, if possible.
set title

" set cursorline
" :highlight CursorLine ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
" :highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40

""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                "
"                 Key Bindings                   "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
"" Map leader to ,
let mapleader=','

" Stay in visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" Allows for copy and paste into the OS clipboard
set clipboard=unnamedplus

" Copy (Yank) selected text to the OS clipboard
noremap <leader>y "+y
" Copy an entire line to the OS clipboard
noremap <leader>Y "+yy

" Paste from the OS clipboard
noremap <leader>p "+p
noremap <leader>P "+P

" Save with ctrl + s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" ctags - Use Ctrl+[ to go back from tag instead of Ctrl+t
"nnoremap <C-[> <C-t>

" Avoid some security problems with directory-specific vimrc files
" This should be the last line of the file.
set secure
