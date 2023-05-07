scriptencoding utf-8

" ddc: UI ----------------------------------------------------------------- {{{
call ddc#custom#patch_global('ui', 'pum')
" }}}

" ddc: source ------------------------------------------------------------- {{{
"call ddc#custom#patch_global('sources', ['nvim-lsp', 'around'])
call ddc#custom#patch_global('sources', ['nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', #{
\   _: #{
\     matchers: ['matcher_fuzzy'],
\     sorters: ['sorter_fuzzy'],
\     converters: ['converter_fuzzy'],
\   },
\   around: #{
\     mark: "[A]",
\   },
\   nvim-lsp: #{
\     mark: "[L]",
\     forceCompletionPattern: '\.\w*|:\w*|->\w*',
\   },
\ })

" }}}

" enable dcc
call ddc#enable()
