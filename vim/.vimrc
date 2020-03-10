if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'ajh17/VimCompletesMe'
Plug 'doums/darcula'
call plug#end()

set termguicolors " truecolor
set laststatus=2 " tall status line
set cmdheight=2 " tall command line
set showcmd " show partial command in lower right corner
set noshowmode " we have a plugin for mode
set cursorline " highlight cursor line
set hlsearch " highlight search matches
set ignorecase " don't force case sensitivity in searches
set smartcase
set number " show line numbers
set hidden " allow switching buffers without saving
set listchars=tab:▸\ ,trail:␣,extends:#,nbsp:· " problematic white-space
set list " show problematic whitespace
set directory-=. " don't create swap in current directory
set showmatch " when closing a parens, hightlight the opening one
set wildmode=list:longest,full " list matches instead of directly auto complete
set complete+=i,kspell
set whichwrap=b,s,h,l,<,>,[,] " allow wrapping with all keys in all modes
set viewoptions+=unix,slash " use slashes for paths and default to unix LF
set shortmess+=I " disable intro message
colorscheme darcula

set nowrap " don't wrap long lines by default
set colorcolumn=79 " marker for rightmost column
hi ColorColumn guibg=darkred ctermbg=1

" fix inconsistency
nnoremap Y y$
" easy navigation of buffers
nnoremap <C-J> :bp<CR>
nnoremap <C-K> :bn<CR>
" use space to enter command mode
nnoremap <Space> :
nnoremap "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" don't keep tabs in python files
autocmd FileType python setlocal tabstop=4 expandtab
" sane style for C
autocmd FileType c,cpp setlocal cinoptions=:0,+4,(4,u0

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \   'bufferline': 'LightlineBufferline'
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before,
	    g:bufferline_status_info.current,
	    g:bufferline_status_info.after]
endfunction

