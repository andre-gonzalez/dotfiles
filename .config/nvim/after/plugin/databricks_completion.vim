" Injects 'databricks' into vim-dadbod-completion's scheme registry.
"
" vim-dadbod-completion looks up vim_dadbod_completion#schemas#get(scheme) to
" find the SQL queries and parsers for schema/column completion. Since 'databricks'
" is not in the plugin's built-in s:schemas dict, we override the public function
" (function! replaces the autoload definition once the plugin is loaded).
"
" vim-dadbod-completion is lazy-loaded (ft=sql via lazy.nvim), so it is NOT
" loaded yet when this after/plugin file runs at startup — the override is
" installed from a User LazyLoad autocmd instead (see bottom of file).
"
" Queries use CONCAT(col, CHAR(9), col) to embed a tab in the output so the
" parser can split reliably regardless of column value widths. databricks_query.py
" emits: header line, separator line, then data lines — parsers skip the first 2.

" --- Parsers ---

" Skips the header+separator lines emitted by databricks_query.py, then splits
" each data line on the embedded tab (CHAR(9)) to produce [col1, col2] pairs.
function! s:parse_tsv(list) abort
  return filter(
        \ map(a:list[2:], {_, l -> map(split(trim(l), '\t'), 'trim(v:val)')}),
        \ 'len(v:val) ==? 2 && !empty(v:val[0])'
        \ )
endfunction

" count_parser: result[2] is the padded count value (e.g., "  4231")
function! s:count_parser(result) abort
  return str2nr(trim(get(a:result, 2, '0')))
endfunction

" --- Databricks scheme dict ---
"
" Every query starts with a "-- no-limit" directive: databricks_query.py
" appends LIMIT 200 to bare SELECTs, which silently truncated completion
" results (only 200 of ~4800 schema/table pairs survived).
"
" Queries read system.information_schema, which spans ALL Unity Catalog
" catalogs — the bare INFORMATION_SCHEMA only covers the session's current
" catalog. Catalog names are injected as extra schema entries (catalog ->
" its schemas), so `catalog.` completes schemas and `schema.` completes
" tables. Limitation: hive_metastore is not part of system.information_schema
" and stays invisible to completion.
"
" count_column_query deliberately returns 1: vim-dadbod-completion only
" bulk-caches columns when the count is <= 10000, but per-table lookups on
" system.information_schema.columns take ~35s each on this warehouse, while
" the one-time bulk fetch of all ~50k pairs costs the same 35s once, async,
" at session start. Forcing the bulk path is the fast option here.

let s:nolimit = "-- no-limit\n"
let s:filters =
      \ " WHERE table_schema <> 'information_schema'"
      \ . " AND NOT startswith(table_catalog, '__databricks')"

let s:base = s:nolimit
      \ . 'SELECT DISTINCT CONCAT(table_name, CHAR(9), column_name) AS combined'
      \ . ' FROM system.information_schema.columns' . s:filters

let s:databricks = {
      \ 'requires_stdin':      v:true,
      \ 'schemas_query':       s:nolimit
      \   . 'SELECT CONCAT(table_schema, CHAR(9), table_name) AS combined'
      \   . ' FROM system.information_schema.tables' . s:filters
      \   . ' UNION ALL'
      \   . ' SELECT CONCAT(catalog_name, CHAR(9), schema_name)'
      \   . ' FROM system.information_schema.schemata'
      \   . " WHERE schema_name <> 'information_schema'"
      \   . " AND NOT startswith(catalog_name, '__databricks')"
      \   . ' ORDER BY combined',
      \ 'schemas_parser':      function('s:parse_tsv'),
      \ 'column_query':        s:base . ' ORDER BY combined',
      \ 'count_column_query':  'SELECT 1 AS total',
      \ 'table_column_query':  {tbl -> s:base . " AND lower(table_name) = lower('" . tbl . "') ORDER BY combined"},
      \ 'column_parser':       function('s:parse_tsv'),
      \ 'count_parser':        function('s:count_parser'),
      \ 'quote':               ['`', '`'],
      \ 'should_quote':        {val -> !empty(trim(val)) && (
      \                          val =~# '\s'
      \                          || has_key(vim_dadbod_completion#reserved_keywords#get_as_dict(), toupper(val))
      \                        )},
      \ }

" --- Override vim_dadbod_completion#schemas#get ---
"
" Pre-load all existing scheme dicts before overriding (s:schemas is
" script-local in the plugin and unreachable after we shadow the function).
" This can only run once the plugin is on the runtimepath, i.e. after
" lazy.nvim has loaded it.

function! s:install() abort
  if get(s:, 'installed', 0)
    return
  endif
  let s:installed = 1

  let s:all_schemes = {}
  for name in ['postgres', 'postgresql', 'mysql', 'mariadb', 'oracle', 'sqlite', 'sqlserver', 'clickhouse']
    let s:all_schemes[name] = vim_dadbod_completion#schemas#get(name)
  endfor
  let s:all_schemes['databricks'] = s:databricks

  function! vim_dadbod_completion#schemas#get(scheme) abort
    return get(s:all_schemes, a:scheme, {})
  endfunction
endfunction

" Called from the vim-dadbod-completion `config` in lua/plugins/vim-dadbod.lua,
" which lazy.nvim runs synchronously right after sourcing the plugin — before
" its FileType autocmd can fetch and cache an empty scheme. The User LazyLoad
" autocmd below is a fallback in case the plugin gets loaded some other way.
function! DatabricksCompletionInstall() abort
  call s:install()
endfunction

function! s:on_lazy_load() abort
  " Note: the plugin sets g:vim_dadbod_completion_loaded (not g:loaded_...)
  if exists('g:vim_dadbod_completion_loaded')
    call s:install()
    autocmd! databricks_completion_setup
  endif
endfunction

if exists('g:vim_dadbod_completion_loaded')
  call s:install()
else
  augroup databricks_completion_setup
    autocmd!
    autocmd User LazyLoad call s:on_lazy_load()
  augroup END
endif
