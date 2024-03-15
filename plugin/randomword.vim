if exists("g:randomword_plugin")
  finish
endif
let g:randomword_plugin = 1

lua require("randomword")
