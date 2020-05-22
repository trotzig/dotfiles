# Runs after a command is executed (or interrupted),
# before the prompt is rendered for the next command.
precmd() {
  # Display exit code if non-zero
  local last_cmd_status=$?
  if [ ! $last_cmd_status -eq 0 ]; then
    echo -e "\033[0;31m→ exit status: $last_cmd_status\033[0m" >&2
  fi

  # Update terminal title bar if one is available
  if [[ "$TERM" =~ xterm* ]]; then
    echo -en "\033]0;$USER@$(hostname):$(__prompt_curdir)\007"
  fi
}

active_git_branch() {
  local ref="$(git symbolic-ref HEAD 2> /dev/null)"
  echo "${ref#refs/heads/}"
}

git_branch_ahead() {
  local branch="$(active_git_branch)"
  (git log origin/$branch..HEAD 2>/dev/null | grep '^commit' >/dev/null 2>&1) \
    && echo '➨'
}

# Prompt escape variables differ between shells, so use functions instead
__prompt_curdir() {
  echo "${PWD/#$HOME/~}"
}

# Display the currently git branch and status if we're in a git repository
__git_prompt() {
  local branch="$(active_git_branch)"
  if [ ! -z "$branch" ]; then
    echo " $(git_branch_ahead)$branch"
  else
    echo ""
  fi
}

# Main prompt line
PS1="%F{gray}$USER@$(hostname -s)%F"
PS1="${PS1}%F{green}:%F{red}$(__prompt_curdir)"
PS1="${PS1}%F{green}$(__git_prompt)"
PS1="${PS1}
%F{33}⨠%F{white} "

# Prompt to display at beginning of next line when command spans multiple lines
PS2="%F{33}↳%F{white} "
