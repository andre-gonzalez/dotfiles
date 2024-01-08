------------------------------------------------------------------------------
----------------------------- ABREVIATIONS -----------------------------------
------------------------------------------------------------------------------

vim.cmd("ab SF SELECT * FROM;<up><right><right><right>")
vim.cmd("ab SLIMIT SELECT *<cr>FROM<cr>LIMIT 200<cr>;<up><up><right><right><right>")
vim.cmd("ab SDIST SELECT DISTINCT<cr>FROM<cr>;<up><right><right><right>")
vim.cmd(
	'ab SCOLUMNS SELECT "column_name"<cr>FROM information_schema."columns"<cr>WHERE "table_name" = \'\'<cr>;<up><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>'
)
vim.cmd("ab skeletonmd #<cr><cr>## Participantes:<cr>- [[]]<cr><cr>---<cr># Notas:<cr>- <cr>---<cr># To-do:<cr>- [ ]")
vim.cmd("ab dcom # COMMAND ----------")
