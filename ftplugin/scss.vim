" let g:neoformat_scss_sass_lint= {
            " \ 'exe': 'sass-lint',
            " \ 'args': ['--no-exit', '--verbose', '--format=compact', '-c /Users/sid/code/work/CallCenter/pguifrontend/.sass-lint.yml'],
            " \ 'errorformat':
            " \ '%E%f: line %l\, col %c\, Error - %m,' .
            " \ '%W%f: line %l\, col %c\, Warning - %m',
            " \ }
" let g:neoformat_scss_enabled_makers = ['sass_lint']

let g:neoformat_scss_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin', '--parser css', '--single-quote'],
            \ 'stdin': 1
            \ }
let g:neoformat_enabled_scss = ['prettier']

autocmd! BufWritePre *.scss Neoformat
" autocmd! BufWritePost *.scss Neomake
