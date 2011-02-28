filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible " Set nocompatible mode on

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

" OS Specific
if has("unix")
	" Configuration for both Cygwin and Linux
	set shellcmdflag=-ic " Use an interactive shell for bang(!)
	if has("win32unix")
		" Configuration for Cygwin only
	else
		" Configuration for Linux only
	endif
elseif has("win32")
	" Configuration for Windows-native vim
else
	echoerr "Unknown OS"
endif

" Set statusline
set laststatus=2

set statusline=%f
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
" set statusline=%<%f\ %y\ %h%m%r%{fugitive#statusline()}\ %{exists('g:loaded_rvm')?rvm#statusline_ft_ruby():''}%=%-14.(%l,%c%V%)\ %P

if has("autocmd")
	au FileType ruby setlocal tabstop=2 shiftwidth=2 " Change indent size to 2 for ruby files
	au BufReadCmd *.epub call zip#Browse(expand("<amatch>")) " Open files inside ePubs
endif

" Clever tab key
"function! SuperCleverTab()
"	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"		return "\<Tab>"
"	else
"		if &omnifunc != ''
"			return "\<C-X>\<C-O>"
"		elseif &dictionary != ''
"			return "\<C-K>"
"		else
"			return "\<C-N>"
"		endif
"	endif
"endfunction

" Key Mappings

" Map SuperCleverTab function to the TAB key
"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" Configure Ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

"Set up SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Make <tab> work more intuitively in visual mode
vmap <tab> >gv
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

"Select all
map <c-a> ggVG

"Remove search highlights
nnoremap <silent> <esc> :noh<return><esc>

" Completion keybindings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Abbreviations

" Change colorscheme from default to vilight
colorscheme vilight

