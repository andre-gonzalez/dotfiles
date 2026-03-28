" vim-dadbod adapter for Databricks SQL Warehouse
"
" URL format:
"   databricks://token:ACCESS_TOKEN@WORKSPACE_HOST/sql/1.0/warehouses/WAREHOUSE_ID
"
" Example:
"   databricks://token:dapi1234abcd@myworkspace.azuredatabricks.net/sql/1.0/warehouses/abc123def456
"
" Setup:
"   pip install databricks-sql-connector

let s:script = expand('<sfile>:p:h:h:h:h') . '/scripts/databricks_query.py'

function! s:parse(url) abort
  " databricks://token:ACCESS_TOKEN@HOST/sql/1.0/warehouses/ID
  let rest     = substitute(a:url, '^databricks://', '', '')
  let at_idx   = stridx(rest, '@')
  let userinfo = strpart(rest, 0, at_idx)
  let hostpath = strpart(rest, at_idx + 1)
  let token    = strpart(userinfo, stridx(userinfo, ':') + 1)
  let slash_idx = stridx(hostpath, '/')
  return {
        \ 'token':     token,
        \ 'host':      strpart(hostpath, 0, slash_idx),
        \ 'http_path': strpart(hostpath, slash_idx),
        \ }
endfunction

function! db#adapter#databricks#canonicalize(url) abort
  return a:url
endfunction

function! db#adapter#databricks#filter(url) abort
  let conn = s:parse(a:url)
  return ['python3', s:script, conn.host, conn.http_path, conn.token]
endfunction

function! db#adapter#databricks#interactive(url) abort
  return db#adapter#databricks#filter(a:url)
endfunction

function! db#adapter#databricks#complete_database(url) abort
  let conn = s:parse(a:url)
  let result = db#systemlist(
        \ ['python3', s:script, conn.host, conn.http_path, conn.token],
        \ "SHOW SCHEMAS")
  return result[2:]
endfunction
