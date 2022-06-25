" Basic Settings
set shell=fish
let mapleader=";"         " The <leader> key
set number
set mouse=a

" Key Mappings
inoremap jj <Esc>
" Get rid of search highlights
noremap <silent><leader>/ :nohlsearch<cr>
" Make navigating around splits easier
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Tab settings
set smarttab
set tabstop=4     " Tabs width in spaces
set softtabstop=4 " Soft tab width in spaces
set shiftwidth=4  " Amount of spaces when shifting
set autoindent
set smartindent

" Search Settings
set ignorecase " Ignore case when searching
set path+=** " Finding files - Search down into subfolders
set wildignore+=*/node_modules/*

" Specify a directory for plugins
call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree	
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
" Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'navarasu/onedark.nvim' " OneDark Pro 
Plug 'nvim-lualine/lualine.nvim' " Status Line
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons; Need patched NerdFonts
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/neoclide/coc.nvim', { 'branch': 'release' } " Auto Completion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better Syntax Highlight
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'windwp/nvim-autopairs' " For auto-closing pairs {}, (), []
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors

set encoding=UTF-8


call plug#end()

" NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nmap <F8> :TagbarToggle<CR>

" Theme
let g:onedark_config = {
    \ 'style': 'darker',
\}
colorscheme onedark

" ##### CocVim Configuration ####
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

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
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" ##### END CocVim Configuration ####

lua << EOF
require("nvim-autopairs").setup {}
require("lualine").setup {}

require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss",
	"java",
	"javascript",
	"typescript",
	"c_sharp"
  },
}
EOF
