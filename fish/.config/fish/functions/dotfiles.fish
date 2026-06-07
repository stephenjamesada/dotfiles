function dotfiles --wraps="ls -A | grep '^\\.'" --description "alias dotfiles ls -A | grep '^\\.'"
  ls -A | grep '^\.' $argv
        
end
