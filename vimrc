filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set nocompatible " Set nocompatible mode on

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on " Turn on syntax highlighting

" Indent automatically depending on filetype
filetype plugin indent on
set autoindent
set smartindent
set cindent

set ruler " Turn on the ruler
set nu " Turn on line numbering.  Turn it off with "set nonu"
set ic " Case insensitive search
set hls " Highlight search
set incsearch " Show incremental search results
set scs " Smart search - override 'ic' when pattern has uppercase characters
set showcmd " Show incomplete commands in the status area
set showmode " Show current mode in the status area
set lbr " Wrap text instead of being on one line
set tabstop=4 " Number of spaces for tab character
set shiftwidth=4 " Number of spaces for autoindent
set noexpandtab " Don't expand tabs into spaces
set novisualbell " Turn off the visual bell
set ttyfast " Smoother changes
set nowrap " Don't wrap lines
set anti " Antialias fonts
set selectmode=mouse,key " Use the mouse for selectmode
set selection=exclusive " Don't include the last character in the selection
set keymodel=startsel,stopsel
set completeopt=longest,menuone " Make completion menu match the longest common text
set switchbuf=usetab,useopen " Make vim open existing tabs/windows if a file is already open rather than opening a new one
set confirm " Prompt to save on destroying buffer with unsaved changes
set updatetime=100 " Set update time to 1/10 second
" OS Specific
if has("unix")
	" Configuration for both Cygwin and Linux
	set shellcmdflag=-ic " Use an interactive shell for bang(!)
	let g:vimhome = $HOME . "/.vim"
	if has("win32unix")
		" Configuration for Cygwin only
	else
		" Configuration for Linux only
	endif
elseif has("win32")
	" Configuration for Windows-native vim
"	source $VIMRUNTIME/mswin.vim
	let g:vimhome = $HOME . "/vimfiles"
else
	echoerr "Unknown OS"
endif

" Set mapleader
let mapleader = ";"

" Set statusline
set laststatus=2

set statusline=%f
set statusline+=[%{&ff}]
set statusline+=%{fugitive#statusline()}
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}
set statusline+=%h
set statusline+=%y
set statusline+=%r
set statusline+=%m
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L
set statusline+=\ %P

let g:netrw_liststyle = 3
let g:jah_Quickfix_Win_Height = 10
let g:ragtag_global_maps = 1

" toggles the quickfix window.
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
	else
		execute "copen " . g:jah_Quickfix_Win_Height
	endif
endfunction

if has("autocmd")
	augroup vimrc
		autocmd!
		au FileType java setlocal omnifunc=javacomplete#Complete
		au FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
		au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))
		au FileType eruby call ExtractSnips(g:vimhome . "/snippets/html", "eruby")
		au FileType eruby call ExtractSnips(g:vimhome . "/after/snippets/html", "eruby")
		au BufRead,BufNewFile pom.xml call ExtractSnips(g:vimhome . "/after/snippets/maven", "xml")
		" Configure omnicomplete to use syntax completion if no other omnifunc exists
		au FileType *
					\ if &omnifunc == "" |
					\ 	setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	augroup END

	" used to track the quickfix window
	augroup QFixToggle
		autocmd!
		autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
		autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
	augroup END

endif

" Configure taglist
let Tlist_Show_One_File = 1

"Configure tagbar
let g:tagbar_autofocus = 1
let g:tagbar_expand = 1

" Key Mappings

" Insert mode cursor movement
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Configure Ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1

"Set up SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Make <tab> work more intuitively in visual mode
vmap <tab> >g
vmap <s-tab> <gv

" Tab key bindings, Firefox like
:nmap <C-S-tab> :tabprevious<CR>
:nmap <C-tab> :tabnext<CR>
:map <C-S-tab> :tabprevious<CR>
:map <C-tab> :tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>i
:imap <C-tab> <Esc>:tabnext<CR>i
:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>

" Change the working directory of this buffer to the location of the file in
" the buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Completion keybindings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" QuickFix window
nmap <silent> <leader>` :QFix<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" TagBar
nnoremap <silent> <F9> :TagbarToggle<CR>

" Copy filename to the clipboard
if has('win32')
	nmap <silent> ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
	nmap <silent> ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
	nmap <silent> ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
else
	" These copy to both the Gnome and X Server clipboard
	nmap <silent> ,cs :let @*=expand("%")<CR>:echo '<C-R>*'<CR> \| :let @+=expand("%")<CR>
	nmap <silent> ,cl :let @*=expand("%:p")<CR>:echo '<C-R>*'<CR> \| :let @+=expand("%:p")<CR>
endif

nnoremap <C-o> :FufFile<CR>
nnoremap <C-b> :FufBuffer<CR>

" Gtags mapping
map <C-\>] :GtagsCursor<CR>

" Capture the output of a command to a new tab
function! Capture (cmd)
	redir => message
	silent execute a:cmd
	redir END
	tabnew
	silent put=message
	set nomodified
endfunction
command! -nargs=+ -complete=command Capture call Capture(<q-args>)

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" AutoComplPop Configuration
let g:acp_enableAtStartup = 0

" Abbreviations

" Change colorscheme from default to vilight
colorscheme railscasts
