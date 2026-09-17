" --- shell ---
augroup shell_tools
    autocmd!
    autocmd FileType sh setlocal makeprg=shellcheck\ % errorformat=%f:%l:%c\ %m
augroup END
