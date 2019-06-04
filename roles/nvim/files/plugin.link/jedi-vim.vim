" Disable usages, which seems to mess with things
let g:jedi#usages_command = ''

" Don't use completion from this Jedi package; use completion from deoplete-jedi
let g:jedi#completions_enabled = 0

" Make jedi use Python3 install
let g:jedi#force_py_version=3
