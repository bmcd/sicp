set nocp
:let localleader = "\\"
execute pathogen#infect()
filetype plugin indent on    " required

" ESC sucks
:inoremap jk <Esc>
:inoremap kj <Esc>

set encoding=utf-8
:set tabstop=2
:set shiftwidth=2
:set expandtab

let g:vundle_default_git_proto='ssh'
" YouCompleteMe settings, close autocomplete window, leader+g goes to hovered definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" pretty colors
let python_highlight_all=1
syntax on

" Line numbering
set relativenumber
set number

" system clipboard
set clipboard=unnamed

set term=screen-256color

set background=dark
" solarized options 
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
colorscheme solarized

" tslime {{{
let g:tslime_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<localleader>t'
let g:tslime_visual_mapping = '<localleader>t'
let g:tslime_vars_mapping = '<localleader>T'
" }}}

" autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

set runtimepath^=~/.vim/bundle/ctrlp.vim
