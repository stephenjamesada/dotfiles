let mapleader = " "

" --- modes ---

" -- normal mode --

" faster command-line mode + ; preservation
nnoremap <silent> ; :
nnoremap <silent> <leader>; ;

" saving, quitting
nnoremap <silent> <leader>w :update<CR>
nnoremap <silent> <leader>q :quit<CR>
nnoremap <silent> <leader>x :xit<CR>

" buffer nav
nnoremap <silent> <leader>b :buffers<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>

" search
nnoremap <silent> <leader>h :nohlsearch<CR>

" netrw
nnoremap <leader>e :Ex<CR>
nnoremap <leader>E :Explore<CR>
nnoremap <leader>v :Vex<CR>
nnoremap <leader>s :Sex<CR>

" -- insert mode --

" fast escape
inoremap <silent> jj <Esc>

" saving, quitting
inoremap <silent> <C-s> <Esc>:update<CR>a
inoremap <silent> <C-x> <Esc>:xit<CR>

" completion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <C-f> <C-x><C-f>
inoremap <C-o> <C-x><C-o>

" auto-pairing
function s:OpenPair(open, close) abort
    let next = strpart()
endfunction

" --- language-specific ---

" -- bash --
nnoremap <silent> <leader>sf :%!shfmt<CR>
