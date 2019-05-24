" let g:neomake_javascript_ctags_maker = { 'exe': '/Users/sid/code/work/scripts/update-pgui-ctags.sh' }

" let g:neomake_javascript_enabled_makers = ['flow', 'eslint', 'ctags']
" autocmd! BufWritePost *.js Neomake

let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin', '--trailing-comma es5', '--single-quote', '--parser babylon'],
            \ 'stdin': 1
            \ }
let g:neoformat_enabled_javascript = ['prettier']

autocmd! BufWritePre *.js Neoformat
