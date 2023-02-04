export ZSH=# Path to your oh-my-zsh installation.

ZSH_THEME="bullet-train"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# AUTO NVM INITIALIZATION
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autoswitch to node version defined in `.nvmrc`, offer to install missing versions.
#
# Prerequisites:
#   - nvm
#   - zsh (should be installed by default on newer macOS systems)

autoload -U add-zsh-hook
load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
        local nvm_file=$(cat "${nvmrc_path}")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            echo -e "❗️ Node version ${nvm_file} defined in .nvmrc is not installed.\n"
            if read -q "choice?❓ Do you wish to install it? [y/N] "; then
                echo -e "\n✅ Installing...\n"
                nvm install
            else
                echo -e "\n⛔️ Skipping install"
            fi
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            echo -e "\n🤖 Switching to node version ${nvm_file} defined in .nvmrc\n"
            nvm use  1> /dev/null
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "💡 Reverting to nvm default version"
        nvm use default  1> /dev/null
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# END nvm auto initializationexport 

# Bullet-train options
BULLETTRAIN_PROMPT_ORDER=(
  dir
  git
)