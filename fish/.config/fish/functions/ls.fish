function ls --wraps='eza -al --git --color=always --icons --group-directories-first --time-style=long-iso --sort=modified --no-permissions --no-user --no-filesize' --description 'alias ls eza -al --git --color=always --icons --group-directories-first --time-style=long-iso --sort=modified --no-permissions --no-user --no-filesize'
  eza -al --git --color=always --icons --group-directories-first --time-style=long-iso --sort=modified --no-permissions --no-user --no-filesize $argv
        
end
