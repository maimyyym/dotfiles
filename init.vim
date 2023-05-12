" ===基本設定===
set number
set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set expandtab
set clipboard=unnamed

" ===プラグイン===
call plug#begin()
Plug 'nordtheme/vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/fern.vim'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" add this line to your .vimrc file
Plug 'mattn/emmet-vim'
call plug#end()

" ===カラースキーム===
colorscheme nord

" ===カラー設定===
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none
"highlight DiffAdd ctermfg=255 ctermbg=224
"highlight DiffDelete ctermfg=255 ctermbg=224
"highlight DiffChange ctermfg=255 ctermbg=224
"highlight DiffText cterm=bold ctermfg=255 ctermbg=224
highlight Comment ctermfg=15

" ===インデント設定===
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ts          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType jsx         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType tsx         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript  setlocal sw=2 sts=2 ts=2 et
endif

" ===vim-airlineの設定===
" ステータスバーの表示変更（z=カーソル位置・最大行,error,warningを非表示）
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ [ 'x', 'y']
	\ ]

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader>    <Nop>
xnoremap <Leader>    <Nop>
nnoremap <Plug>(lsp) <Nop>
xnoremap <Plug>(lsp) <Nop>
nmap     m           <Plug>(lsp)
xmap     m           <Plug>(lsp)
nnoremap <Plug>(ff)  <Nop>
xnoremap <Plug>(ff)  <Nop>
nmap     ;           <Plug>(ff)
xmap     ;           <Plug>(ff)

" キー
inoremap <silent> jk <ESC>
nnoremap gr :tabprevious
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:user_emmet_leader_key='<c-t>'

" ===coc.nvim===
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-git', 'coc-fzf-preview', 'coc-lists']

inoremap <silent> <expr> <C-Space> coc#refresh()

nnoremap <silent> K             <Cmd>call <SID>show_documentation()<CR>
nmap     <silent> <Plug>(lsp)rn <Plug>(coc-rename)
nmap     <silent> <Plug>(lsp)a  <Plug>(coc-codeaction-cursor)

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> <Plug>(lsp)f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
  autocmd!
  autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction


" ===fzf.vimの設定===
" Ctrl-pでファイルを開く
nnoremap <C-p> :Files<CR>
" Ctrl-gでgit管理下のファイルを開く
nnoremap <C-g> :GFiles<CR>
" Ctrl-bでバッファを切り替える
nnoremap <C-b> :Buffers<CR>
" Ctrl-fでファイル内を検索する
nnoremap <C-f> :Ag<SPACE>

" ===fern.vimの設定===
:nmap <buffer> s <Plug>(fern-action-open:split)
:nmap <buffer> vs <Plug>(fern-action-open:vsplit)
let g:fern#default_hidden=1

" ===fzf-preview===
" batのカラーテーマ
let $BAT_THEME                     = 'Sublime Snazzy'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'Sublime Snazzy'

nnoremap <silent> <Plug>(ff)r  <Cmd>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent> <Plug>(ff)s  <Cmd>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> <Plug>(ff)gg <Cmd>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> <Plug>(ff)b  <Cmd>CocCommand fzf-preview.Buffers<CR>
nnoremap          <Plug>(ff)f  :<C-u>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>

nnoremap <silent> <Plug>(lsp)q  <Cmd>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> <Plug>(lsp)rf <Cmd>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> <Plug>(lsp)d  <Cmd>CocCommand fzf-preview.CocDefinition<CR>
nnoremap <silent> <Plug>(lsp)t  <Cmd>CocCommand fzf-preview.CocTypeDefinition<CR>
nnoremap <silent> <Plug>(lsp)o  <Cmd>CocCommand fzf-preview.CocOutline --add-fzf-arg=--exact --add-fzf-arg=--no-sort<CR>

" ===全文検索===
" Ripgrepを使用する場合
if executable('rg')
  " Use ripgrep in fzf
  set rtp+=~/.fzf
  let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
  command! -bang -nargs=* RG call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
  nnoremap <silent> <Leader>g :RG<Space>
endif


" ===markdown-pritter設定===
" [markdown] configure formatprg
autocmd FileType markdown set formatprg=prettier\ --parser\ markdown

" [markdown] format on save
autocmd! BufWritePre *.md call s:mdfmt()
function s:mdfmt()
    let l:curw = winsaveview()
    silent! exe "normal! a \<bs>\<esc>" | undojoin |
        \ exe "normal gggqG"
    call winrestview(l:curw)
endfunction


" 補完
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-e>" : "<CR>"
" エンターキーで補完
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
