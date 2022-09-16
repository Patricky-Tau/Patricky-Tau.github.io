if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu
set rnu
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set scrolloff=4
set ignorecase

silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

let mapleader=" "
vnoremap Y "+y
noremap <LEADER>Y :%y+<CR>
noremap <LEADER>M :e ~/.config/nvim/init.vim<CR>
noremap <LEADER><CR> :nohlsearch<CR>

map <C-j> 5<C-e>
map <C-k> 5<C-y>
noremap <M-j> :m .+1<CR>==
noremap <M-k> :m .-2<CR>==
inoremap <M-j> <ESC>:m .+1<CR>==gi
inoremap <M-k> <ESC>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
noremap qf <C-w>o

noremap s <nop>
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

noremap <UP> :res +5<CR>
noremap <DOWN> :res -5<CR>
noremap <LEFT> :vertical resize-5<CR>
noremap <RIGHT> :vertical resize+5<CR>

noremap sh <C-w>t<C-w>K
noremap sv <C-w>t<C-w>H
noremap sch <C-w>b<C-w>K
noremap scv <C-w>b<C-w>H

noremap tn :tabe<CR>
noremap tN :tab split<CR>
noremap tu :-tabnext<CR>
noremap td :+tabnext<CR>
noremap tmu :-tabmove<CR>
noremap tmd :+tabmove<CR>

function! SearchPlaceHolder()
	call search("<++>", 'w')
	:norm zz<CR>
endfunction
map <LEADER><LEADER> <ESC>:call SearchPlaceHolder()<CR>c4l
map <LEADER>m mko<++><ESC>`k:delmarks k<CR>

noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
noremap \s :%s//g<LEFT><LEFT>
noremap \r :g//d<LEFT><LEFT>

noremap r :call CompileRunGcc()<CR>
func SplitBelow()
    set splitbelow
    sp
    res -5
endfunc

func! CompileRunGcc()
	exec "w"
	if &filetype == 'cpp'
		call SplitBelow()
		term cpl %
	elseif &filetype == 'python'
		call SplitBelow()
		term python3 %
	elseif &filetype == 'markdown' || &filetype == 'vimwiki'
        exec "MarkdownPreview"
	endif
endfunc

noremap sr :call CompileRunGccR()<CR>
func SplitRight()
    set splitright
    vsp
    vertical res -20
endfunc

func! CompileRunGccR()
	 exec "w"
	 if &filetype == 'cpp'
        call SplitRight()
	    term cpl %
	 elseif &filetype == 'python'
	    call SplitRight()
	    term python3 %
	 elseif &filetype == 'markdown' || &filetype == 'vimwiki'
        exec "MarkdownPreview"
	 endif
endfunc

call plug#begin('$HOME/.config/nvim/plugged')

Plug 'preservim/tagbar', { 'on': 'TagbarOpenAutoClose' }

Plug 'morhetz/gruvbox'
Plug 'ajmwagar/vim-deus'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'

Plug 'ibhagwan/fzf-lua'

Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp'] }

Plug 'mbbill/undotree'

Plug 'cohama/agit.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for': ['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'vimwiki/vimwiki'

Plug 'rhysd/accelerated-jk'
Plug 'karb94/neoscroll.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'junegunn/goyo.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-pack/nvim-spectre'

Plug 'itchyny/calendar.vim'

Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'

Plug 'rlue/vim-barbaric'
Plug 'lambdalisue/suda.vim'
call plug#end()

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" silent! color gruvbox
" silent! color catppuccin_macchiato
silent! color deus

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)

lua << EOF
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb', },
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})
EOF

hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermfg=gray guifg=grey10
hi SpecialKey ctermfg=blue guifg=grey70

let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ==================== vim-table-mode ====================
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" ==================== Undotree ====================
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc

" ==================== vim-visual-multi ====================
let g:VM_leader					 = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps					   = {}
let g:VM_maps['Remove Region']	  = 'q'
let g:VM_maps['Skip Region']		= 'n'
let g:VM_maps["Undo"]			   = 'u'
let g:VM_maps["Redo"]			   = '<C-r>'


" ==================== nvim-spectre ====================
nnoremap <LEADER>f <cmd>lua require('spectre').open()<CR>
vnoremap <LEADER>f <cmd>lua require('spectre').open_visual()<CR>

" ==================== vim-calendar ====================
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
	autocmd!
	" diamond cursor
	autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
	autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
	autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
	autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
	autocmd FileType calendar nmap <buffer> <c-k> <Plug>(calendar_move_up)
	autocmd FileType calendar nmap <buffer> <c-h> <Plug>(calendar_move_left)
	autocmd FileType calendar nmap <buffer> <c-j> <Plug>(calendar_move_down)
	autocmd FileType calendar nmap <buffer> <c-l> <Plug>(calendar_move_right)
	autocmd FileType calendar nmap <buffer> i <Plug>(calendar_start_insert)
	autocmd FileType calendar nmap <buffer> I <Plug>(calendar_start_insert_head)
	autocmd FileType calendar nunmap <buffer> <C-n>
	autocmd FileType calendar nunmap <buffer> <C-p>
augroup END


" ==================== goyo ====================
map <LEADER>gy :Goyo<CR>


" ==================== tabular ====================
vmap ga :Tabularize /

" ==================== rainbow ====================
let g:rainbow_active = 1

" ==================== suda.vim ====================
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%

" ==================== vimspector ====================
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ==================== vim-markdown-toc ====================
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ==================== NERDCommenter ====================
let g:NERDSpaceDelims			= 1
let g:NERDCompactSexyComs		= 1
let g:NERDDefaultAlign		   = 'left'
let g:NERDAltDelims_java		 = 1
let g:NERDCustomDelimiters	   = { 'php': { 'left': '/*','right': '*/' },'html': { 'left': '<!--','right': '-->' },'py': { 'left': '#' },'sh': { 'left': '#' } }
let g:NERDCommentEmptyLines	  = 1
let g:NERDTrimTrailingWhitespace = 1


" ==================== tag list ====================
let g:tagbar_ctags_bin = '/usr/bin/ctags'
map <silent> <LEADER>T :TagbarOpenAutoClose<CR>

" ==================== Agit ====================
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1

" ==================== fzf-lua ====================
noremap <silent> <C-p> :FzfLua files<CR>
noremap <silent> <C-h> :FzfLua oldfiles cwd=~<CR>
noremap <silent> <C-q> :FzfLua builtin<CR>
noremap <silent> <C-t> :FzfLua lines<CR>
noremap <silent> z= :FzfLua spell_suggest<CR>
noremap <silent> <C-w> :FzfLua buffers<CR>
augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end

lua <<EOF
require'fzf-lua'.setup {
	global_resume = true,
	global_resume_query = true,
	winopts = {
		height = 0.95,
		width = 0.95,
		preview = {
			scrollbar = 'float',
		},
		fullscreen = false,
		vertical	   = 'down:45%',	  -- up|down:size
		horizontal	 = 'right:60%',	 -- right|left:size
		hidden		 = 'nohidden',
		title = true,
	},
	keymap = {
		-- These override the default tables completely
		-- no need to set to `false` to disable a bind
		-- delete or modify is sufficient
		builtin = {
			["<c-f>"]	  = "toggle-fullscreen",
			["<c-r>"]	  = "toggle-preview-wrap",
			["<c-p>"]	  = "toggle-preview",
			["<c-j>"]	  = "preview-page-down",
			["<c-k>"]	  = "preview-page-up",
			["<S-left>"]   = "preview-page-reset",
		},
		fzf = {
			["esc"]		= "abort",
			["ctrl-h"]	 = "unix-line-discard",
			["ctrl-k"]	 = "half-page-down",
			["ctrl-j"]	 = "half-page-up",
			["ctrl-n"]	 = "beginning-of-line",
			["ctrl-a"]	 = "end-of-line",
			["alt-a"]	  = "toggle-all",
			["f3"]		 = "toggle-preview-wrap",
			["f4"]		 = "toggle-preview",
			["shift-down"] = "preview-page-down",
			["shift-up"]   = "preview-page-up",
			["ctrl-e"]	 = "down",
			["ctrl-u"]	 = "up",
		},
	},
  previewers = {
	cat = {
	  cmd			 = "cat",
	  args			= "--number",
	},
	bat = {
	  cmd			 = "bat",
	  args			= "--style=numbers,changes --color always",
	  theme		   = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
	  config		  = nil,			-- nil uses $BAT_CONFIG_PATH
	},
	head = {
	  cmd			 = "head",
	  args			= nil,
	},
	git_diff = {
	  cmd_deleted	 = "git diff --color HEAD --",
	  cmd_modified	= "git diff --color HEAD",
	  cmd_untracked   = "git diff --color --no-index /dev/null",
	  -- pager		= "delta",	  -- if you have `delta` installed
	},
	man = {
	  cmd			 = "man -c %s | col -bx",
	},
	builtin = {
	  syntax		  = true,		 -- preview syntax highlight?
	  syntax_limit_l  = 0,			-- syntax limit (lines), 0=nolimit
	  syntax_limit_b  = 1024*1024,	-- syntax limit (bytes), 0=nolimit
	},
  },
  files = {
	-- previewer	  = "bat",		  -- uncomment to override previewer
										-- (name from 'previewers' table)
										-- set to 'false' to disable
	prompt			= 'Files❯ ',
	multiprocess	  = true,		   -- run command in a separate process
	git_icons		 = true,		   -- show git icons?
	file_icons		= true,		   -- show file icons?
	color_icons	   = true,		   -- colorize file|git icons
	-- executed command priority is 'cmd' (if exists)
	-- otherwise auto-detect prioritizes `fd`:`rg`:`find`
	-- default options are controlled by 'fd|rg|find|_opts'
	-- NOTE: 'find -printf' requires GNU find
	-- cmd			= "find . -type f -printf '%P\n'",
	find_opts		 = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
	rg_opts		   = "--color=never --files --hidden --follow -g '!.git'",
	fd_opts		   = "--color=never --type f --hidden --follow --exclude .git",
  },
  buffers = {
	prompt			= 'Buffers❯ ',
	file_icons		= true,		 -- show file icons?
	color_icons	   = true,		 -- colorize file|git icons
	sort_lastused	 = true,		 -- sort buffers() by last used
  },
}
EOF


" ==================== lazygit.nvim ====================
noremap <c-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " for neovim-remote support


" ==================== Terminal Colors ====================
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'

exec "nohlsearch"

" my cpp template files
function! SearchPlaceHolder2()
	call search("<+>", 'w')
endfunction

function NewFileHeader()
  " :0r !echo -e '/* HOW %< ? \c' && date "+\%Y-\%m-\%d \%H:\%M:\%S" && echo '*/'
  :0r !echo -e '// g++ % -std=c++23 -fsanitize=undefined -g -Wall -Wextra -Wfatal-errors -Os -DLOCAL -o %<'
  :0
  :join
endfunc

function NewFileCode()
  :call NewFileHeader()
  :r ~/.config/nvim/snippets/code.cpp
endfunc

function NewFileCodF()
  :call NewFileHeader()
  :r ~/.config/nvim/snippets/cf.cpp
endfunc

au FileType cpp map <LEADER>R mkgg:call SearchPlaceHolder2()<CR>j<ESC>:r $HOME/.config/nvim/snippets/.hpp<LEFT><LEFT><LEFT><LEFT>
au FileType cpp map <LEADER>K `k:delmarks k<CR>zz
au BufNewFile *.cpp exec ":call NewFileCode()"
au FileType cpp map <LEADER>N ggdGqwq:call NewFileCode()<CR>
au FileType cpp map <LEADER>C ggdGqwq:call NewFileCodF()<CR>

let g:barbaric_ime = 'fcitx'

""" markdown-preview
let g:mkdp_auto_start		 = 0
let g:mkdp_auto_close		 = 1
let g:mkdp_theme			  = 'light'
let g:mkdp_highlight_css = ''
let g:mkdp_browser = 'surf'
" let g:mkdp_browser = 'google-chrome-stable'

""" sticky line highlight
highlight LineHighlight ctermbg=grey guibg=black
nnoremap <silent> <LEADER>x :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
nnoremap <silent> <LEADER>X :call clearmatches()<CR>
