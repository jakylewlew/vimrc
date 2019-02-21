
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
let mapleader =","

set relativenumber
set tabstop=4

function! StartFormalLatex()
	exe "normal" "i\\documentclass[11pt]{article}\<CR>\\usepackage{times}\<CR>\\usepackage[margin=1.0in]{geometry}\<CR>\\usepackage[singlespacing]{setspace}\<CR>\\setlength{\\parskip}{\\baselineskip}\<CR>\<CR>\\makeatletter\<CR>\\newcommand{\\verbatimfont}[1]{\\def\verbatim@font{#1}}%\<CR>\\makeatother\<CR>\\begin{document}\<CR>\<CR>\\end{document}"
	exe "normal" "ki"
endfunction


function! CreateSectionNote()
	exe "normal" "i\\section{}"
endfunction

function! InsertItem()
	exe "normal" "i\\begin{itemize}\<CR>\<CR>\\end{itemize}"
	exe "normal" "ki\\item "
	startinsert
endfunction
function! InsertEnumerate()
	exe "normal" "i\\begin{enumerate}\<CR>\<CR>\\end{enumerate}"
	exe "normal" "ki\\item "
	startinsert	
endfunction


function! InsertVerbatim()
     exe "normal" "i\\begin{verbatim}\<CR>\CR>\\end{verbatim}\<Esc>"
     exe "normal" "ki"
	 startinsert	
	
endfunction
function! CreateSubsection()
	exe "normal" "i\\subsection{}"
	startinsert
endfunction
function! InsertTime()
	put	=strftime('%T')
	exe "normal" "yyk$p"	
endfunction
function! CompileLatex()
	!pdflatex %
	!xdg-open %<.pdf
endfunction	
nnoremap <Leader>l :call StartFormalLatex() <CR>
nnoremap <Leader>S :call CreateSubsection() <CR>
nnoremap <Leader>s :call CreateSectionNote() <CR>
nnoremap <Leader>i :call InsertItem() <CR>
nnoremap <Leader>b :call InsertVerbatim() <CR>
nnoremap <Leader>t : call InsertTime() <CR>

nnoremap <Leader>c : call CompileLatex() <CR>

nnoremap <Leader>n :call InsertEnumerate() <CR>

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
