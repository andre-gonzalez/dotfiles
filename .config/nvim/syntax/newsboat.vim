" Highlight header keys like Feed:, Title:, etc.
syntax match newsboatHeader /^\(Feed\|Title\|Author\|Date\|Link\|Links\):/
syntax match newsboatURL /https\?:\/\/[^\s]*/
syntax match newsboatDate /\w\{3\},\s\d\{1,2\}\s\w\{3\}\s\d\{4\}/

" Define highlight groups (you can tweak the colors)
hi def link newsboatHeader Keyword
hi def link newsboatURL Underlined
hi def link newsboatDate Number
