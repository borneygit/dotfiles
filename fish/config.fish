# Configuration file for fish shell.
# Filepath: ~/.config/fish/config.fish
# Fish shell: https://fishshell.com/
# Fish plugin manager: https://github.com/jorgebucaran/fisher

# https://github.com/pure-fish/pure
# Leader symbol for fish prompt
set pure_symbol_prompt "\$"
set pure_color_virtualenv magenta
set pure_show_jobs true
set pure_color_jobs blue
set pure_show_system_time false

# Async prompt
set -g async_prompt_functions _pure_prompt_git
# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't show any greetings
set fish_greeting ""

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command; end

# Basic environments
set -x SHELL fish
set -x TERM screen-256color
set -x EDITOR nvim
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
set -x HOMEBREW_NO_AUTO_UPDATE 1

# $PATH environment variables
set -e fish_user_paths
set -gx fish_user_paths \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/sbin \
    /usr/bin \
    /sbin \
    /bin \
    $fish_user_paths

# >>> vscode initialize >>>
function code
    set location "$PWD/$argv"
    open -n -b "com.microsoft.VSCode" --args $location
end
# <<< vscode initialize <<<

rvm default

source ~/.fish_profile
