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

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
