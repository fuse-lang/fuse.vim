" Vim syntax file
" Language:     Fuse
" Maintainer:   Ali Rezvani <rzvxa 'at' protonmail com>
" Original Authors:
"         Marcus Aurelius Farias <masserahguard-lua 'at' yahoo com>
"         Carlos Augusto Teixeira Mendes <cmendes 'at' inf puc-rio br>
" Last Change:  2024 Jan 9

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

" syncing method
syn sync minlines=1000

syn keyword fuseMetaMethod __add __sub __mul __div __pow __unm __concat
syn keyword fuseMetaMethod __eq __lt __le
syn keyword fuseMetaMethod __index __newindex __call
syn keyword fuseMetaMethod __metatable __mode __gc __tostring

syn keyword fuseMetaMethod __mod __len

" syn keyword fuseMetaMethod __pairs

syn keyword fuseMetaMethod __idiv __name
syn keyword fuseMetaMethod __band __bor __bxor __bnot __shl __shr

syn keyword fuseMetaMethod __close

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region fuseParen transparent start='(' end=')' contains=TOP,fuseParenError
" syn match  fuseParenError ")"
" syn match  fuseError "}"
syn match  fuseError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region fuseFunctionBlock transparent matchgroup=fuseFunction start="\<function\>" end="\<end\>" contains=TOP
syn region fuseFnBlock transparent matchgroup=fuseFunction start="\v<fn>(.{-})\((.{-})\)(.{-})&(.*\=\>)@!" end="\<end\>" contains=TOP
" syn keyword fuse contained containedin=fuseFor fn

" else
syn keyword fuseCondElse matchgroup=fuseCond contained containedin=fuseCondEnd else

" then ... end
syn region fuseCondEnd contained transparent matchgroup=fuseCond start="\<then\>" end="\<end\>" contains=TOP

" elseif ... then
syn region fuseCondElseif contained containedin=fuseCondEnd transparent matchgroup=fuseCond start="\<elseif\>" end="\<then\>" contains=TOP

" if ... then
syn region fuseCondStart transparent matchgroup=fuseCond start="\<if\>" end="\<then\>"me=e-4 contains=TOP nextgroup=fuseCondEnd skipwhite skipempty

" do ... end
syn region fuseBlock transparent matchgroup=fuseStatement start="\<do\>" end="\<end\>" contains=TOP
" repeat ... until
syn region fuseRepeatBlock transparent matchgroup=fuseRepeat start="\<repeat\>" end="\<until\>" contains=TOP

" while ... do
syn region fuseWhile transparent matchgroup=fuseRepeat start="\<while\>" end="\<do\>"me=e-2 contains=TOP nextgroup=fuseBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region fuseFor transparent matchgroup=fuseRepeat start="\<for\>" end="\<do\>"me=e-2 contains=TOP nextgroup=fuseBlock skipwhite skipempty

syn keyword fuseFor contained containedin=fuseFor in

" other keywords
syn keyword fuseStatement return const let global break

" operators
syn keyword fuseOperator and or not

syn match fuseSymbolOperator "[#<>=~^&|*/%+-]\|\.\{2,3}"

" comments
syn keyword fuseTodo            contained TODO FIXME XXX
syn match   fuseComment         "--.*$" contains=fuseTodo,@Spell

" multiline comments
syn region fuseComment        matchgroup=fuseCommentDelimiter start="--\[\z(=*\)\[" end="\]\z1\]" contains=fuseTodo,@Spell

" first line may start with #!
syn match fuseComment "\%^#!.*"

syn keyword fuseConstant nil
syn keyword fuseConstant true false

" strings
syn match  fuseSpecial contained #\\[\\abfnrtv'"[\]]\|\\[[:digit:]]\{,3}#
syn match  fuseSpecial contained #\\z\|\\x[[:xdigit:]]\{2}#
syn match  fuseSpecial contained #\\u{[[:xdigit:]]\+}#
syn region fuseString2 matchgroup=fuseStringDelimiter start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell

syn region fuseString matchgroup=fuseStringDelimiter start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=fuseSpecial,@Spell
syn region fuseString matchgroup=fuseStringDelimiter start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=fuseSpecial,@Spell

" integer number
syn match fuseNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match fuseNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\="
" floating point number, starting with a dot, optional exponent
syn match fuseNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match fuseNumber  "\<\d\+[eE][-+]\=\d\+\>"

" hex numbers
syn match fuseNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"

" tables
syn region fuseTableBlock transparent matchgroup=fuseTable start="{" end="}" contains=TOP,fuseStatement

" struct end
syn region fuseStructBlock transparent matchgroup=fuseStruct start="\<struct\>" end="\<end\>" contains=TOP

" impl ... for ... end
syn region fuseImplBlock transparent matchgroup=fuseImpl start="\<impl\>" end="\<end\>" contains=TOP

syn keyword fuseImplBlock contained containedin=fuseImpl for

" methods
syntax match fuseFunc ":\@<=\k\+"

" built-in functions
syn keyword fuseFunc assert collectgarbage dofile error next
syn keyword fuseFunc print rawget rawset self tonumber tostring type _VERSION

syn keyword fuseFunc getmetatable setmetatable
syn keyword fuseFunc ipairs pairs
syn keyword fuseFunc pcall xpcall
syn keyword fuseFunc _G loadfile rawequal require
syn keyword fuseFunc load select
syn keyword fuseFunc getfenv setfenv
syn keyword fuseFunc rawlen

syn match fuseFunc /\<coroutine\.running\>/
syn match   fuseFunc /\<coroutine\.create\>/
syn match   fuseFunc /\<coroutine\.resume\>/
syn match   fuseFunc /\<coroutine\.status\>/
syn match   fuseFunc /\<coroutine\.wrap\>/
syn match   fuseFunc /\<coroutine\.yield\>/

" string lib
syn match   fuseFunc /\<string\.byte\>/
syn match   fuseFunc /\<string\.char\>/
syn match   fuseFunc /\<string\.dump\>/
syn match   fuseFunc /\<string\.find\>/
syn match   fuseFunc /\<string\.format\>/
syn match   fuseFunc /\<string\.gsub\>/
syn match   fuseFunc /\<string\.len\>/
syn match   fuseFunc /\<string\.lower\>/
syn match   fuseFunc /\<string\.rep\>/
syn match   fuseFunc /\<string\.sub\>/
syn match   fuseFunc /\<string\.upper\>/
syn match fuseFunc /\<string\.gmatch\>/
syn match fuseFunc /\<string\.match\>/
syn match fuseFunc /\<string\.reverse\>/
syn match fuseFunc /\<string\.pack\>/
syn match fuseFunc /\<string\.packsize\>/
syn match fuseFunc /\<string\.unpack\>/

" utf-8
syn match fuseFunc /\<utf8\.char\>/
syn match fuseFunc /\<utf8\.charpattern\>/
syn match fuseFunc /\<utf8\.codes\>/
syn match fuseFunc /\<utf8\.codepoint\>/
syn match fuseFunc /\<utf8\.len\>/
syn match fuseFunc /\<utf8\.offset\>/

" table lib
syn match fuseFunc /\<table\.maxn\>/
syn match fuseFunc /\<table\.pack\>/
syn match fuseFunc /\<table\.unpack\>/
syn match fuseFunc /\<table\.move\>/
syn match   fuseFunc /\<table\.concat\>/
syn match   fuseFunc /\<table\.insert\>/
syn match   fuseFunc /\<table\.sort\>/
syn match   fuseFunc /\<table\.remove\>/

" bit32
syn match   fuseFunc /\<bit32\.arshift\>/
syn match   fuseFunc /\<bit32\.band\>/
syn match   fuseFunc /\<bit32\.bnot\>/
syn match   fuseFunc /\<bit32\.bor\>/
syn match   fuseFunc /\<bit32\.btest\>/
syn match   fuseFunc /\<bit32\.bxor\>/
syn match   fuseFunc /\<bit32\.extract\>/
syn match   fuseFunc /\<bit32\.lrotate\>/
syn match   fuseFunc /\<bit32\.lshift\>/
syn match   fuseFunc /\<bit32\.replace\>/
syn match   fuseFunc /\<bit32\.rrotate\>/
syn match   fuseFunc /\<bit32\.rshift\>/

" math
syn match   fuseFunc /\<math\.abs\>/
syn match   fuseFunc /\<math\.acos\>/
syn match   fuseFunc /\<math\.asin\>/
syn match   fuseFunc /\<math\.atan\>/
syn match   fuseFunc /\<math\.atan2\>/
syn match   fuseFunc /\<math\.ceil\>/
syn match   fuseFunc /\<math\.sin\>/
syn match   fuseFunc /\<math\.cos\>/
syn match   fuseFunc /\<math\.tan\>/
syn match   fuseFunc /\<math\.deg\>/
syn match   fuseFunc /\<math\.exp\>/
syn match   fuseFunc /\<math\.floor\>/
syn match   fuseFunc /\<math\.log\>/
syn match   fuseFunc /\<math\.max\>/
syn match   fuseFunc /\<math\.min\>/
syn match fuseFunc /\<math\.huge\>/
syn match fuseFunc /\<math\.fmod\>/
syn match fuseFunc /\<math\.modf\>/
syn match fuseFunc /\<math\.cosh\>/
syn match fuseFunc /\<math\.sinh\>/
syn match fuseFunc /\<math\.tanh\>/
syn match   fuseFunc /\<math\.rad\>/
syn match   fuseFunc /\<math\.sqrt\>/
syn match   fuseFunc /\<math\.pow\>/
syn match   fuseFunc /\<math\.frexp\>/
syn match   fuseFunc /\<math\.ldexp\>/
syn match   fuseFunc /\<math\.random\>/
syn match   fuseFunc /\<math\.randomseed\>/
syn match   fuseFunc /\<math\.pi\>/

" io module
syn match   fuseFunc /\<io\.close\>/
syn match   fuseFunc /\<io\.flush\>/
syn match   fuseFunc /\<io\.input\>/
syn match   fuseFunc /\<io\.lines\>/
syn match   fuseFunc /\<io\.open\>/
syn match   fuseFunc /\<io\.output\>/
syn match   fuseFunc /\<io\.popen\>/
syn match   fuseFunc /\<io\.read\>/
syn match   fuseFunc /\<io\.stderr\>/
syn match   fuseFunc /\<io\.stdin\>/
syn match   fuseFunc /\<io\.stdout\>/
syn match   fuseFunc /\<io\.tmpfile\>/
syn match   fuseFunc /\<io\.type\>/
syn match   fuseFunc /\<io\.write\>/

" os module
syn match   fuseFunc /\<os\.clock\>/
syn match   fuseFunc /\<os\.date\>/
syn match   fuseFunc /\<os\.difftime\>/
syn match   fuseFunc /\<os\.execute\>/
syn match   fuseFunc /\<os\.exit\>/
syn match   fuseFunc /\<os\.getenv\>/
syn match   fuseFunc /\<os\.remove\>/
syn match   fuseFunc /\<os\.rename\>/
syn match   fuseFunc /\<os\.setlocale\>/
syn match   fuseFunc /\<os\.time\>/
syn match   fuseFunc /\<os\.tmpname\>/

" debug module
syn match   fuseFunc /\<debug\.debug\>/
syn match   fuseFunc /\<debug\.gethook\>/
syn match   fuseFunc /\<debug\.getinfo\>/
syn match   fuseFunc /\<debug\.getlocal\>/
syn match   fuseFunc /\<debug\.getupvalue\>/
syn match   fuseFunc /\<debug\.setlocal\>/
syn match   fuseFunc /\<debug\.setupvalue\>/
syn match   fuseFunc /\<debug\.sethook\>/
syn match   fuseFunc /\<debug\.traceback\>/
syn match fuseFunc /\<debug\.getfenv\>/
syn match fuseFunc /\<debug\.setfenv\>/
syn match fuseFunc /\<debug\.getmetatable\>/
syn match fuseFunc /\<debug\.setmetatable\>/
syn match fuseFunc /\<debug\.getregistry\>/

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link fuseStatement        Statement
hi def link fuseRepeat           Repeat
hi def link fuseFor              Repeat
hi def link fuseString           String
hi def link fuseString2          String
hi def link fuseStringDelimiter  fuseString
hi def link fuseNumber           Number
hi def link fuseOperator         Operator
hi def link fuseSymbolOperator   fuseOperator
hi def link fuseConstant         Constant
hi def link fuseCond             Conditional
hi def link fuseCondElse         Conditional
hi def link fuseFunction         Function
hi def link fuseMetaMethod       Function
hi def link fuseComment          Comment
hi def link fuseCommentDelimiter fuseComment
hi def link fuseTodo             Todo
hi def link fuseTable            Structure
hi def link fuseStruct           Structure
hi def link fuseImpl             Structure
hi def link fuseError            Error
hi def link fuseParenError       Error
hi def link fuseSpecial          SpecialChar
hi def link fuseFunc             Identifier
hi def link fuseLabel            Label


let b:current_syntax = "fuse"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: et ts=8 sw=2
