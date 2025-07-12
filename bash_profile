# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if [ -f /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
else
  if [[ -f /etc/profile.d/bash_completion.sh ]]; then
    source /etc/profile.d/bash_completion.sh
  fi
fi

if [[ -f ~/.iterm2_shell_integration.bash ]]; then
	source ~/.iterm2_shell_integration.bash
fi

if [[ -f /opt/ros/galactic/setup.bash ]]; then
	source /opt/ros/galactic/setup.bash
fi

if type dircolors &>/dev/null; then
        export LS_OPTIONS='--color=auto'
        if [[ -f ~/.dircolors ]]; then
          eval "$(dircolors -b ~/.dircolors)"
        else
          eval "$(dircolors -b)"
        fi
        alias ls='ls $LS_OPTIONS'
fi

if command -v ngrok &>/dev/null; then
        eval "$(ngrok completion)"
fi

if command -v rbenv &>/dev/null; then
        eval "$(rbenv init -)"
fi

[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ -S "/Users/rhettg/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]]; then
  export SSH_AUTH_SOCK="/Users/rhettg/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
else
  echo "no file"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
