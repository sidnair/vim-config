set shiftwidth=4
set softtabstop=4
set expandtab

let b:ale_linters = ['flake8', 'pylint']

let g:ale_fix_on_save = 1
let b:ale_fixers = ['black', 'autopep8']
