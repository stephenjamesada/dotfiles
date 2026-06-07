function weather --wraps='curl wttr.in/St.+Louis' --description 'alias weather curl wttr.in/St.+Louis'
  curl wttr.in/St.+Louis $argv
        
end
