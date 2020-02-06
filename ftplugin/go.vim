set noexpandtab
set shiftwidth=4
set tabstop=4


" Per https://github.com/dense-analysis/ale/issues/2983, govet doesn't work, so gobuild is better. gofmt also works, but it seems like gopls may cover all the use cases.
let b:ale_linters = ['gopls', 'golint']
let b:ale_fixers = ['gofmt', 'goimports']
let b:ale_fix_on_save = 1

" Overlapping vim-go functionality with ALE
let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_asmfmt_autosave = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_doc_keywordprg_enabled = 0

" https://github.com/Shougo/deoplete.nvim/issues/965
call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})
