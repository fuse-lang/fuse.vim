" Vim filetype indent file
" Language:    Fuse
" Maintainer:  None yet

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

" Fuse is a superset of Lua
runtime! indent/lua.vim
