function fbat --wraps="find . -type f | fzf --preview 'cat --style=numbers --color=always --wrap=auto {}' | xargs vim" --description "alias fbat find . -type f | fzf --preview 'cat --style=numbers --color=always --wrap=auto {}' | xargs mdless"
    find . -type f | fzf --preview 'cat --style=numbers --color=always --wrap=auto {}' | xargs mdless $argv

end
