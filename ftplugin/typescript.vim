let g:ale_fix_on_save = 1
let b:ale_fixers = ['prettier', 'tslint']

" let g:neomake_typescript_ctags_maker = { 'exe': '/Users/sid/code/work/scripts/update-pgui-ctags.sh' }

" let g:neomake_typescript_enabled_makers = ['flow', 'eslint', 'ctags']
" let g:neomake_typescript_enabled_makers = ['tsc']

" autocmd! BufWritePost *.ts Neomake
" autocmd! BufWritePost *.tsx Neomake

" let g:neoformat_typescript_prettier = {
            " \ 'exe': 'prettier',
            " \ 'args': ['--stdin',  '--parser babel'],
            " \ 'stdin': 1
            " \ }
" let g:neoformat_enabled_typescript = ['prettier']

" autocmd! BufWritePre *.ts Neoformat
" autocmd! BufWritePre *.tsx Neoformat
