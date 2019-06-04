" Key remap
noremap <Leader>n :NERDTreeToggle<cr>

" Files to ignore
" Array of regular expressions to match omissions by
let NERDTreeIgnore = [
      \'\.class$',
      \'\.pyc$',
      \'\.egg-info[[dir]]',
      \'__pycache__[[dir]]',
      \'^bower_components[[dir]]',
      \'^node_modules[[dir]]',
      \'^tmp[[dir]]',
      \'^deps[[dir]]'
      \]

let g:NERDSpaceDelims = 1
let g:gitgutter_enabled = 1

" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 35

" faster bookmarking in NERDTree
autocmd Filetype nerdtree nnoremap <buffer> <leader>B :Bookmark<space>
autocmd Filetype nerdtree nnoremap <buffer> <leader>b :Bookmark<space><CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1

" Open NERDTree by default and with no command line args
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"Close NERDTree if it's all that's left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree's File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('hs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('rkt', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('py', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('scala', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('py3', 'Magenta', 'none', '#ff00ff', '#151515')
" }}}

" nerdtree mappings
let NERDTreeMapChangeRoot = 'u'
let NERDTreeMapUpdir = 'U'
let NERDTreeMapUpdirKeepOpen = 'c'
