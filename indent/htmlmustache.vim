" Indent plugin for mustache template files
"
" Thanks to Juvenn Woo.
" http://github.com/juvenn
"
" Code taken from mustache/vim-mustache-handlebars on Github.
" https://github.com/mustache/vim-mustache-handlebars

if exists("b:did_indent_hbs")
  finish
endif

unlet! b:did_indent
setlocal indentexpr=

runtime! indent/html.vim
unlet! b:did_indent

" Force HTML indent to not keep state.
let b:html_indent_usestate = 0

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:handlebars_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1
let b:did_indent_hbs = 1

setlocal indentexpr=GetHandlebarsIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when

" Only define the function once.
if exists("*GetHandlebarsIndent")
  finish
endif

function! GetHandlebarsIndent(...)
  " The value of a single shift-width
  if exists('*shiftwidth')
    let sw = shiftwidth()
  else
    let sw = &sw
  endif

  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')
  call cursor(v:lnum,1)
  call cursor(v:lnum,vcol)
  exe "let ind = ".b:handlebars_subtype_indentexpr

  " Workaround for Andy Wokula's HTML indent. This should be removed after
  " some time, since the newest version is fixed in a different way.
  if b:handlebars_subtype_indentexpr =~# '^HtmlIndent('
  \ && exists('b:indent')
  \ && type(b:indent) == type({})
  \ && has_key(b:indent, 'lnum')
    " Force HTML indent to not keep state
    let b:indent.lnum = -1
  endif
  let lnum = prevnonblank(v:lnum-1)
  let line = getline(lnum)
  let cline = getline(v:lnum)

  " all indent rules only apply if the block opening/closing
  " tag is on a separate line

  " indent after block {{#block
  if line =~# '\v\s*\{\{\#.*\s*'
    let ind = ind + sw
  endif
  " unindent after block close {{/block}}
  if cline =~# '\v^\s*\{\{\/\S*\}\}\s*'
    let ind = ind - sw
  endif
  " unindent {{else}}
  if cline =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind - sw
  endif
  " indent again after {{else}}
  if line =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind + sw
  endif

  return ind
endfunction
