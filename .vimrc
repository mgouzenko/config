set autoindent
set tabstop=4
set noexpandtab
set shiftwidth=4
filetype indent on
syntax on
set nocompatible
set backspace=2
set number

" Highlight the current line.
set cursorline

" Turn on tab completion for commands
set wildmenu

" Dynamic searching
set incsearch

" Highlight when searching
set hlsearch

" Enable folding
set foldenable
set foldlevelstart=5
set foldmethod=indent

set modelines=1


colorscheme desertEx

" Key Mapping {{{
nnoremap <Return> za
noremap <C-j> :resize +3<CR>
noremap <C-k> :resize -3<CR>
noremap <C-h> :vertical resize -3<CR>
noremap <C-l> :vertical resize +3<CR>
map <silent> <Right> :wincmd l <CR>
map <silent> <Left> :wincmd h <CR>
noremap <silent> <Up> :wincmd k <CR>
noremap <silent> <Down> :wincmd j <CR>

let mapleader=","
nnoremap <leader>s :mksession<CR>

" Move visually (instead of by line number)
nnoremap j gj
nnoremap k gk


" Use space to eliminate highlighting after search
noremap <silent> <Space> :noh <CR>

" }}}
" Highlighting {{{
" Highlight extra white space with green and overlength lines with red.
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
highlight ExtraWhitespace ctermbg=darkgreen ctermfg=white guibg=#FFD9D9

" Adjust the definition of what it means to be trailing white space
" Make it so that when you're writing, the whitespace at the end is
" not considered trailing.
match OverLength /\%>80v.\+/

function! AdjustWhitespaceEnter()
	match ExtraWhitespace /\s\+\%#\@<!$/
	call matchadd('OverLength', '\%>80v.\+')
endfunction

function! AdjustWhitespaceExit()
	match ExtraWhitespace /\s\+$/
	call matchadd('OverLength', '\%>80v.\+')
endfunction

au InsertEnter * call AdjustWhitespaceEnter()
au InsertLeave * call AdjustWhitespaceExit()

" }}}

autocmd vimenter * NERDTree

"Function to close vim if Nerd Tree is the only thing left open
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

" For all text files set 'textwidth' to 78
" characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.  Don't do.
" it when the position is invalid or when inside an event handler (happens when.
" dropping a file on gvim). Also don't do it when the mark is in the first line.
" " that is the default position when opening a file.
autocmd BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif

" Pathogen load
call pathogen#infect()
call pathogen#helptags()


" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%f
set statusline+=%5(%)
set statusline+=[%{strftime(\"%c\",getftime(expand(\"%:p\")))}]
set statusline+=%=
set statusline+=line:\%l\ col:\%c
set statusline+=%5(%)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

" allow ycm to play nicely with syntastic
let g:ycm_show_diagnostics_ui = 0

execute pathogen#infect()

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/bundle/ctrlp.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Notes
Plugin 'xolox/vim-notes'
let g:notes_directories = ['~/google_drive/notes']

" Vim misc required by vim notes
Plugin 'xolox/vim-misc'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin on

" vim:foldmethod=marker:foldlevel=0
