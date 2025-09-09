let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/go/src/github.com/gost-dom/harmony
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/go/src/github.com/gost-dom/harmony
badd +12 internal/features/auth/authrouter/logout_test.go
badd +1 ~/.config/nvim/init.lua
badd +1 ~/.config/nvim/pack/stroiman/opt/gotest/README.md
badd +1 ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest.lua
badd +262 ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest/test_run.lua
argglobal
%argdel
$argadd ~/go/src/github.com/gost-dom/harmony
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit internal/features/auth/authrouter/logout_test.go
argglobal
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 11 - ((10 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 023|
lcd ~/go/src/github.com/gost-dom/harmony
tabnext
edit ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest/test_run.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 99 + 99) / 198)
exe 'vert 2resize ' . ((&columns * 98 + 99) / 198)
tcd ~/.config/nvim
argglobal
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 262 - ((28 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 262
normal! 024|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest.lua", ":p")) | buffer ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest.lua | else | edit ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/pack/stroiman/opt/gotest/lua/gotest.lua
endif
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 114 - ((25 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 114
normal! 0
lcd ~/.config/nvim
wincmd w
exe 'vert 1resize ' . ((&columns * 99 + 99) / 198)
exe 'vert 2resize ' . ((&columns * 98 + 99) / 198)
tabnext 2
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
