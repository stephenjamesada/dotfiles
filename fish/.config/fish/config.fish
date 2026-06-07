set -gx PATH $HOME/.rbenv/bin $PATH

if status is-login
    if test (tty) = /dev/tty1
        and not set -q WAYLAND_DISPLAY
        and not set -q DISPLAY
        exec sway
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Environment variables
set -x FILE_MANAGER nnn
set -x EDITOR vim
set -x VISUAL vim
set -x BROWSER librewolf
set -x PAGER less
set -x GIT_PAGER "$PAGER"

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_CACHE_HOME

set -x HISTSIZE 5000
set -x SAVEHIST 5000

set -x TMPDIR $HOME/.tmp

# Created by `pipx` on 2025-09-17 23:06:14
set PATH $PATH /home/stephen/.local/bin
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
set -gx ATUIN_SESSION (atuin uuid)
set --erase ATUIN_HISTORY_ID

function _atuin_preexec --on-event fish_preexec
    if not test -n "$fish_private_mode"
        set -g ATUIN_HISTORY_ID (atuin history start -- "$argv[1]")
    end
end

function _atuin_postexec --on-event fish_postexec
    set -l s $status

    if test -n "$ATUIN_HISTORY_ID"
        ATUIN_LOG=error atuin history end --exit $s -- $ATUIN_HISTORY_ID &>/dev/null &
        disown
    end

    set --erase ATUIN_HISTORY_ID
end

function _atuin_search
    set -l keymap_mode
    switch $fish_key_bindings
        case fish_vi_key_bindings
            switch $fish_bind_mode
                case default
                    set keymap_mode vim-normal
                case insert
                    set keymap_mode vim-insert
            end
        case '*'
            set keymap_mode emacs
    end

    # In fish 3.4 and above we can use `"$(some command)"` to keep multiple lines separate;
    # but to support fish 3.3 we need to use `(some command | string collect)`.
    # https://fishshell.com/docs/current/relnotes.html#id24 (fish 3.4 "Notable improvements and fixes")
    set -l ATUIN_H (ATUIN_SHELL=fish ATUIN_LOG=error ATUIN_QUERY=(commandline -b) atuin search --keymap-mode=$keymap_mode $argv -i 3>&1 1>&2 2>&3 | string collect)

    if test -n "$ATUIN_H"
        if string match --quiet '__atuin_accept__:*' "$ATUIN_H"
          set -l ATUIN_HIST (string replace "__atuin_accept__:" "" -- "$ATUIN_H" | string collect)
          commandline -r "$ATUIN_HIST"
          commandline -f repaint
          commandline -f execute
          return
        else
          commandline -r "$ATUIN_H"
        end
    end

    commandline -f repaint
end

function _atuin_bind_up
    # Fallback to fish's builtin up-or-search if we're in search or paging mode
    if commandline --search-mode; or commandline --paging-mode
        up-or-search
        return
    end

    # Only invoke atuin if we're on the top line of the command
    set -l lineno (commandline --line)

    switch $lineno
        case 1
            _atuin_search --shell-up-key-binding
        case '*'
            up-or-search
    end
end

if string match -q '4.*' $version
    bind ctrl-r _atuin_search
    bind up _atuin_bind_up
    if bind -M insert >/dev/null 2>&1
        bind -M insert ctrl-r _atuin_search
        bind -M insert up _atuin_bind_up
    end
else
    bind \cr _atuin_search
    bind -k up _atuin_bind_up; bind \eOA _atuin_bind_up; bind \e\[A _atuin_bind_up
    if bind -M insert >/dev/null 2>&1
        bind -M insert \cr _atuin_search
        bind -M insert -k up _atuin_bind_up; bind -M insert \eOA _atuin_bind_up; bind -M insert \e\[A _atuin_bind_up
    end
end
