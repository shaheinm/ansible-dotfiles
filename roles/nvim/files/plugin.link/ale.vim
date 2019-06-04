let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'html': ['tidy'],
\   'python': ['flake8', 'pylint'],
\   'java': ['checkstyle', 'javac'],
\   'go': ['golint'],
\   'vue': ['eslint']
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'python': ['autopep8','isort', 'yapf'],
\   'java': ['google_java_format'],
\   'json': ['jq', 'fixjson', 'prettier'],
\   'go': ['gofmt', 'goimports'],
\   'vue': ['eslint', 'prettier'],
\   'html': ['tidy', 'prettier']
\}

nmap <leader>d <Plug>(ale_fix)

" Use a slightly slimmer error pointer
let g:ale_sign_error = '✖'
hi ALEErrorSign guifg=#DF8C8C
let g:ale_sign_warning = '⚠'
hi ALEWarningSign guifg=#F2C38F

" Use ALT-k and ALT-j to navigate errors
nmap <silent> ˚ <Plug>(ale_previous_wrap)
nmap <silent> ∆ <Plug>(ale_next_wrap)

" Do not lint or fix minified files
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
