inoremap jk <ESC> 
set relativenumber
syntax on
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set scrolloff=10

" =================================
" ==============自定义=============
" =================================
set clipboard+=unnamedplus
set nu
set cul
set foldenable
set autoindent
set termguicolors
let mapleader = " "

call plug#begin()
" vim写数据库
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" 代码缩略
Plug 'wfxr/minimap.vim'
" 颜色
Plug 'lunarvim/synthwave84.nvim'
" VIMIM命令
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" 大纲
Plug 'majutsushi/tagbar'
"通知优化
Plug 'rcarriga/nvim-notify'
" 主题
Plug 'hardhackerlabs/theme-vim', { 'as': 'hardhacker' }
Plug 'EdenEast/nightfox.nvim' 
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'morhetz/gruvbox'
" 快速注释
Plug 'scrooloose/nerdcommenter'
" NB高亮
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 文件搜索
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
" 文件树
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'nvim-tree/nvim-tree.lua'
" 标签页
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" 状态栏
Plug 'nvim-lualine/lualine.nvim'
" 代码格式化
Plug 'mhartington/formatter.nvim'
" 彩虹括号
Plug 'luochen1990/rainbow'
" 缩进显示
" Plug 'shellRaining/hlchunk.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
" 启动UI
Plug 'glepnir/dashboard-nvim'
" Plug 'goolord/alpha-nvim'
" 括号补全
Plug 'jiangmiao/auto-pairs'
" UI
Plug 'folke/noice.nvim'
" Plug 'MunifTanjim/nui.nvim'
" 启动时间
Plug 'dstein64/vim-startuptime'
" 在nvim中启动一个终端
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()
let g:indentLine_fileTypeExclude = ['dashboard','help']


" 滚动条
let g:minimap_auto_start = 1
let g:minimap_width = 10
hi MinimapCurrentLine ctermfg=Green guifg=#50FA7B guibg=#32302f
let g:minimap_cursor_color = 'MinimapCurrentLine'

" vim命令补全
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
      \ 'border': 'rounded',
      \ 'max_height': '75%',
      \ 'min_height': 0,
      \ 'prompt_position': 'top',
      \ 'reverse': 0,
      \ })))

" 大纲
nnoremap <C-k> :TagbarToggle<cr>


" 主题
" set background=dark
" autocmd vimenter * ++nested colorscheme gruvbox
colorscheme  catppuccin
" colorscheme nightfox
" colorscheme hardhacker

" 启动一个终端
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
lua require("toggleterm").setup()

" 快速注释
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = { 'php': { 'left': '/*','right': '*/' },'html': { 'left': '<!--','right': '-->' },'py': { 'left': '#' },'sh': { 'left': '#' } }
filetype plugin on

" 补全
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()


" 文件搜索
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" 代码格式化
nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

" 彩虹括号
let g:rainbow_active = 1

" 标签页
set termguicolors
lua << EOF
require("bufferline").setup{}
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>bc", ":bdelete %<CR>", {noremap = true, silent = true})


-- 文件树
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
  },
})

-- 状态栏 
--require('lualine').setup({options = { theme = 'gruvbox' }})
require('lualine').setup {options = {theme = "catppuccin"}}

-- 代码缩进线
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,

     char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}



-- 启动终端
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- 通知优化



