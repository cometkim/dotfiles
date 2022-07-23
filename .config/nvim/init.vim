set nocompatible " be iMproved, required

set encoding=utf-8
set fileencoding=utf-8

set nobackup
set nowritebackup

" Numbers
set number relativenumber
set numberwidth=4
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end

set ruler
set noswapfile
set nobackup
set nowritebackup
set incsearch
set autowrite
set autoread
set termguicolors
set mouse=a

" Indentation
set cindent
set autoindent
set smartindent

" Tabs
set tabstop=2
set shiftwidth=2
set backspace=2
set expandtab
set shiftround

set splitbelow
set splitright

set t_Co=256
set t_ut=

cabbrev ㅈ w
cabbrev ㅂ q
cabbrev ㅈㅂ wq

set clipboard^=unnamed,unnamedplus

" Plugins
call plug#begin(exists('s:plug') ? s:plug : '~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-json', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-yaml', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-html', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-highlight', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-git', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-css', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-stylelint', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-yank', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-smartf', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-lists', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
Plug 'weirongxu/coc-explorer', { 'do': 'yarn install --frozen-lockfile' }

Plug 'coc-extensions/coc-svelte', { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/coc-svg', { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/coc-diagnostic', { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/coc-spell-checker', { 'do': 'yarn install --frozen-lockfile' }
Plug 'amiralies/coc-flow', { 'do': 'yarn install --frozen-lockfile' }
Plug 'voldikss/coc-gist', { 'do': 'yarn install --frozen-lockfile' }
Plug 'cometkim/coc-browser', { 'do': 'yarn install --frozen-lockfile' }
Plug 'felippepuhle/coc-graphql', { 'do': 'yarn install --frozen-lockfile' }
Plug 'yaegassy/coc-html-css-support', { 'do': 'yarn install --frozen-lockfile' }
Plug 'yaegassy/coc-htmlhint', { 'do': 'yarn install --frozen-lockfile' }
Plug 'pantharshit00/coc-prisma', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-pyright', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-rust-analyzer', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-sql', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-xml', { 'do': 'yarn install --frozen-lockfile' }
Plug 'josa42/coc-sh', { 'do': 'yarn install --frozen-lockfile' }
Plug 'kkiyama117/coc-toml', { 'do': 'yarn install --frozen-lockfile' }
Plug 'antonk52/coc-cssmodules', { 'do': 'npm ci' }
Plug 'rescript-lang/vim-rescript'
Plug 'josa42/coc-go', { 'do': 'yarn install --frozen-lockfile' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'pantharshit00/vim-prisma'
Plug 'pantharshit00/coc-prisma', { 'do': 'yarn install --frozen-lockfile' }
Plug 'gleam-lang/gleam.vim'
Plug 'fannheyward/coc-deno', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-styled-components', { 'do': 'yarn install --frozen-lockfile' }
Plug 'cdata/vim-tagged-template'

Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ryanoasis/vim-devicons'
Plug 'APZelos/blamer.nvim'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

call plug#end()

" Theme
syntax on

" Theme - dracula
color dracula
colorscheme dracula

set guifont=Hack\ Nerd\ Font\ Mono\ 14
set termguicolors

" for React
autocmd BufNewFile,BufRead *.jsx
  \ set filetype=javascript.jsx |
  \ set syntax=javascriptreact
autocmd BufNewFile,BufRead *.tsx
  \ set filetype=typescript.tsx |
  \ set syntax=typescriptreact

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_next = '<C-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
nnoremap <silent> <space><space>    :<C-u>CocFzfList<CR>
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocFzfList diagnostics<cr>
nnoremap <silent><nowait> <space>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocFzfList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocFzfList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" nnoremap <silent><nowait> <space>s  :<C-u>CocFzfList symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocFzfListResume<CR>

" coc-explorer
:nnoremap <space>e :CocCommand explorer<CR>

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" coc-git
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

nnoremap <silent> <space>gs  :<C-u>CocList --normal gstatus<CR>
nnoremap <silent> <space>gc  :<C-u>CocList --normal commits<CR>
nnoremap <silent> <space>gf  :<C-u>CocList --normal gfiles<CR>

" coc-smartf
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
nmap , <Plug>(coc-smartf-repeat-opposite)
augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

" coc-lists
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction
function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction
" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

" plasticboy/vim-markdown (is included in vim-polyglot)
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_fenced_languages = ['html', 'css', 'scss', 'sql', 'js=javascript', 'jsx=javascriptreact', 'ts=typescript', 'tsx=typescriptreact', 're=reason', 'res=rescript', 'go', 'python', 'bash=sh', 'c', 'ruby']

" fatih/vim-go
" let g:go_gopls_enabled = 0

" josa42/coc-go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

let g:blamer_enabled = 1

" rescript-lang/vim-rescript
"
" Note that <buffer> allows us to use different commands with the same keybindings depending
" on the filetype. This is useful if to override your e.g. ALE bindings while working on
" ReScript projects.
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>r :RescriptFormat<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>t :RescriptTypeHint<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>b :RescriptBuild<CR>
autocmd FileType rescript nnoremap <silent> <buffer> gd :RescriptJumpToDefinition<CR>
" Hooking up the ReScript autocomplete function
set omnifunc=rescript#Complete
" When preview is enabled, omnicomplete will display additional
" information for a selected item
set completeopt+=preview

" cdata/vim-tagged-template
let g:taggedtemplate#tagSyntaxMap = {
  \ "html":    "html",
  \ "md":      "markdown",
  \ "gql":     "graphql",
  \ "graphql": "graphql",
  \ "css":     "css"
  \}
autocmd FileType javascript,javascriptreact,typescript,typescriptreact : call taggedtemplate#applySyntaxMap()

" Navigation
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

nnoremap <silent> <C-S-l> gt
nnoremap <silent> <C-S-h> gT

nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l

tnoremap <silent> <Esc><Esc> <C-\><C-n>
