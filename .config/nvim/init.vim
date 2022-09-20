lua require('plugins')
lua require('lspconfig')


let configs = [
            \  "ui",
            \]
for file in configs
    let x = file.".vim"
    if filereadable(x)
        execute 'source' x
    endif
endfor

augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set mouse=a
set number

" Open file finder
nmap <Tab> :Buffers<CR>
nmap <S-Tab> :Files<CR>
nmap <c-g> :GFiles?<CR>
nmap ° :Rg<CR> 

" Buffer control
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

autocmd BufEnter * silent! lcd %:p:h

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" diagnostic setup 
" autocmd BufWinEnter * silent! :Trouble
autocmd InsertCharPre,CursorMoved,CursorHold * silent! :TroubleRefresh
nmap <silent> <F8> :exe "TroubleToggle quickfix"<CR>

" jump to the next item, skipping the groups
nmap <silent> <F2> lua require("trouble").next({skip_groups = true, jump = true});

" jump to the previous item, skipping the groups
nmap <silent> <F3> lua require("trouble").previous({skip_groups = true, jump = true});

" Vimtex
let g:vimtex_view_method = 'skim'
syntax enable


" NerdTree
autocmd VimEnter * :NERDTree
nmap <F6> :NERDTreeToggle<CR>
autocmd VimEnter * wincmd p " move to main window

" Highlight current file in NerTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
map <C-o> :NERDTreeToggle %<CR>

if has('termguicolors')
    " set termguicolors 
endif
colorscheme gruvbox

" MarkdownPreview
" Start automatically when entering Markdown Buffer
autocmd BufWinEnter *.md MarkdownPreview

" Markdown: Insert image from clipboard
command -nargs=1 MdPng :exe "normal i ![](" . <f-args> . ".png \"\")" | :!pngpaste <f-args>.png

" Rust 
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

" Rust
" " Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF


-- nvim_lsp object
local nvim_lsp = require'lspconfig'


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
capabilities=capabilities,
-- on_attach is a callback called when the language server attachs to the buffer
-- on_attach = on_attach,
settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
        -- enable clippy diagnostics on save
        checkOnSave = {
            command = "clippy"
            },
        }
    }
})

-- Setup diagnostics 
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
}
)
EOF

" COC setup


" https://github.com/folke/trouble.nvim/issues/12#issuecomment-882470958
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
            \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
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
"nmap <silent> <F8> :CocDiagnostics<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocIfNoDiagnostic()<CR>

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

