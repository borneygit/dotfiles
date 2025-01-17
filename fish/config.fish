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
set -g __fish_git_prompt_showdirtystate yes
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
function __fish_describe_command
end

# Basic environments
set -x SHELL fish
set -x TERM screen-256color
set -x EDITOR nvim
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -gx SDKMAN_DIR ~/.sdkman

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

set -gx fish_user_paths \
    ~/bin \
    ~/.local/bin \
    /usr/local/go/bin \
    $fish_user_paths

set -gx LDFLAGS "-L/usr/local/opt/node@20/lib"
set -gx CPPFLAGS "-I/usr/local/opt/node@20/include"

set -gx JAVA_HOME $(/usr/libexec/java_home)
set -gx HOMEBREW_NO_AUTO_UPDATE true
set -gx PQ_LIB_DIR "$(brew --prefix libpq)/lib"
set -gx SSLKEYLOGFILE ~/tls/sslkeylog.log
set -gx HDC_SERVER_PORT 7035

alias http_proxy 'export http_proxy=http://127.0.0.1:7890'
alias https_proxy 'export https_proxy=http://127.0.0.1:7890'
alias all_proxy 'export all_proxy=http://127.0.0.1:7890'
alias unhttp_proxy 'unset http_proxy'
alias unhttps_proxy 'unset https_proxy'
alias unall_proxy 'unset all_proxy'
alias proxy_test 'curl -v google.com'

alias l 'ls -alh'
alias la 'ls -a'
alias lla 'ls -la'
alias lt 'ls --tree'
alias vim nvim
alias vi nvim
alias v nvim

set -gx RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -gx RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"

source ~/.fish_profile
source ~/miniconda3/etc/fish/conf.d/conda.fish
starship init fish | source

set -gx LIBRARY_PATH $LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
# set -gx CC clang #brew install llvm
# set -gx CC x86_64-w64-mingw32-gcc #brew install mingw-w64
# set -gx CC gcc #brew install mingw-w64
