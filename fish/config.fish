set fish_greeting "Hello @hademohamed"

# Default Vim Key Bindings
fish_vi_key_bindings
# fish_default_key_binding

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias vim nvim

set -gx EDITOR nvim

# NVM
# Need bass plugin; Install using Oh-My-Fish `omf install bass`
function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent
