" =======================================================================
"
" IMPORTANT REMINDER
"
" All color-values can be found at:
" http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
"
" =======================================================================


set nocompatible              " be iMproved, required
" =======================================================================
"	fish
" =======================================================================
" From: https://github.com/dag/vim-fish
if &shell =~# 'fish$'
	set shell=/bin/bash
endif
" =======================================================================
"	fish End
" =======================================================================

" =======================================================================
"	Vundle
" =======================================================================
" set the runtime path to include Vundle and initialize
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required & must be first!
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" Plugin 'tpope/vim-sensible'
" Plugin 'rstacruz/vim-opinion'

" Repeat.vim sets up bindings other plugins can use to make their commands
" repeatable with the . command.
" https://github.com/tpope/vim-repeat
Plugin 'tpope/vim-repeat'

" Fugitive is a highly-capable Git wrapper for Vim.
" https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'

" Unimpaired.vim provides shortcuts for various paired activities:
"
" ex cmds: ]q is :cnext, [q is :cprevious. ]b is :bnext, [b is :bprev.
" See the documentation for the full set of 20 mappings and mnemonics.
" All of them take a count.
"
" lines: [<Space> and ]<Space> add newlines before and after the
" cursor line. [e and ]e exchange the current line with the one above
" or below it.
"
" toggling options: [os, ]os, and cos perform :set spell, :set
" nospell, and :set invspell, respectively. There's also l (list), n
" (number), w (wrap), x (cursorline cursorcolumn), and several others,
" plus mappings to help alleviate the set paste dance. Consult the
" documentation.
"
" misc: [f and ]f to go to the next/previous file in the directory,
" and [n and ]n to jump between SCM conflict markers.
"
" https://github.com/tpope/vim-unimpaired
Plugin 'tpope/vim-unimpaired'

" This is an addon for Vim providing support for editing fish scripts.
" https://github.com/dag/vim-fish
Plugin 'dag/vim-fish'

" Neatstatus.vim provides a lightweight statusline.
" The aim of Neat Status is to provide neat, and simple UI with just basic
" information and no bells and whistles for those users who consider things
" like Powerline to be overkill.
" https://github.com/maciakl/vim-neatstatus
Plugin 'maciakl/vim-neatstatus'

" Surround.vim lets you add/change/remove surrounding chars and tags
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

" Syntax checker for many languages
" https://github.com/scrooloose/syntastic
Plugin 'scrooloose/syntastic'

" SnipMate aims to provide support for textual snippets, similar to TextMate
" or other Vim plugins. Activate by typing some text and hitting <tab>.
" Snipmate depends on tlib and mw-utils.
" https://github.com/garbas/vim-snipmate
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Plugin 'Shougo/unite.vim'
Plugin 'kballard/vim-swift'
Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'
"Plugin 'ap/vim-buftabline'
Plugin 'junegunn/seoul256.vim'	" colorscheme

call vundle#end()
filetype plugin indent on     " required!
" =======================================================================
"	Vundle End
" =======================================================================

let mapleader = ","

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·

" Switch syntax coloring on
syntax on

:set showbreak=↪︎\ 
command! -nargs=* Wrap set wrap linebreak nolist

" autosave changes to .vimrc
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

" open .vimrc in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" =======================================================================
"	Tabs
" =======================================================================
" Tabstop settings
set tabstop=3
set softtabstop=3
set shiftwidth=3
set noexpandtab

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction
" =======================================================================
"	Tabs End
" =======================================================================

" set margin for linenumbers
set number
set relativenumber
set numberwidth=6
"set cursorline
set spelllang=en,nl

set wildmode=list,full

colorscheme base16-ocean
set background=dark
highlight clear CursorLine
highlight LineNr ctermbg=0 ctermfg=15
highlight CursorLineNr ctermbg=7 ctermfg=0
highlight StatusLine ctermbg=8 ctermfg=15

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" =======================================================================
"	NeatStatusLine
" =======================================================================
let g:NeatStatusLine_separator = '⎜'
let g:NeatStatusLine_color_line     = 'guifg=#ff00ff guibg=#000000 gui=bold ctermfg=9 ctermbg=7 cterm=bold'
let g:NeatStatusLine_color_filetype = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=237 ctermbg=7 cterm=NONE'
" =======================================================================
"	NeatStatusLine End
" =======================================================================
let g:agprg="ag --column --smart-case"

