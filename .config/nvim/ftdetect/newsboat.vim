au BufReadPost * if expand("%") == "" && exists("$NEWSBOAT") | set filetype=newsboat | endif
