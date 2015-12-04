" Vim indent file
" Language: Yaml
" Authors: Ian Young, Martin Toma <http://www.martintoma.com>

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal autoindent shiftwidth=2 expandtab
setlocal indentexpr=GetYamlIndent()
setlocal indentkeys=o,O,*<Return>,!^F

function! g:GetYamlIndent()
  let l:prevlnum = v:lnum - 1

  if l:prevlnum == 0
    return 0
  endif

  let l:line = substitute(getline(v:lnum),'\s\+$','','')
  let l:prevline = substitute(getline(l:prevlnum),'\s\+$','','')

  let l:indent = indent(l:prevlnum)
  let l:increase = l:indent + &shiftwidth
  let l:decrease = l:indent - &shiftwidth

  if l:prevline =~# ':$'
    return l:increase
  elseif l:prevline =~? '^\s\+\-' && l:line =~? '^\s\+[^-]\+:'
    return l:decrease
  else
    return l:indent
  endif
endfunction
