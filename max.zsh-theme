#amalgamation of linuxonly and mortalscumbag themes

autoload -Uz add-zsh-hook
#autoload -Uz vcs_info

local c0=$(printf "\033[0m")
local c1=$(printf "\033[38;5;215m")
local c2=$(printf "\033[38;5;209m")
local c3=$(printf "\033[38;5;203m")
local c4=$(printf "\033[33m")
local c4b=$(printf "\033[4m")
local c5=$(printf "\033[38;5;137m")
local c6=$(printf "\033[38;5;240m")
local c7=$(printf "\033[38;5;149m")
local c8=$(printf "\033[38;5;126m")

if [ "$TERM" = "linux" ]; then
    c1=$(printf "\033[34;1m")
    c2=$(printf "\033[35m")
    c3=$(printf "\033[31m")
    c4=$(printf "\033[31;1m")
    c5=$(printf "\033[32m")
    c6=$(printf "\033[32;1m")
    c7=$(printf "\033[33m")
    c8=$(printf "\033[33;1m")
fi

function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return
  
  INDEX=$(git status --porcelain 2> /dev/null)
  AHEAD=$(git rev-list --count @{u}..HEAD 2> /dev/null)
  BEHIND=$(git rev-list --count HEAD..@{u} 2> /dev/null)
  STAGED=$(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' | wc -l | xargs)
  UNSTAGED=$(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' | wc -l | xargs)
  UNTRACKED=$(echo "$INDEX" | grep '^?? ' | wc -l | xargs)
  STATUS=""


  if [[ $AHEAD -gt 0 ]] || [[ $BEHIND -gt 0 ]]; then

    # is branch ahead?
    if [[ $AHEAD -gt 0 ]]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$AHEAD"
    fi

    # is branch behind?
    if [[ $BEHIND -gt 0 ]]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$BEHIND"
    fi
    STATUS=" $STATUS%{$c0%}"
  fi

#is branch clean?
if [ -n "$(git status --porcelain)" ]; then
  
  STATUS="$STATUS | "
  
  # is anything staged?
  if [[ $STAGED -gt 0 ]]; then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$STAGED "
  fi

  # is anything unstaged?
  if [[ $UNSTAGED -gt 0 ]]; then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED$UNSTAGED "
  fi

  # is anything untracked?
  if [[ $UNTRACKED -gt 0 ]]; then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED$UNTRACKED "
  fi
  
  # clean up last trailing space
  if [[ -n $STATUS ]]; then
    STATUS=$(echo "$STATUS" | sed 's/ *$//g')
  fi

fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

# function ssh_connection() {
#   if [[ -n $SSH_CONNECTION ]]; then
#     echo "%{$fg_bold[red]%}(ssh) "
#   fi
# }

dir_status="%{$c1%}%n%{$c4%}@%{$c0%}%{$c2%}%m%{$c0%} %{$c4%}%{$c4b%}%/ %{$c0%}(%{$c5%}%?%{$c0%})"
PROMPT='${dir_status} ${ret_status}%{$reset_color%}$(my_git_prompt)
> '

#ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$c5%}git%{$c0%}(%{$c5%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[green]%}↓"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$c3%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}?"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg_bold[white])%{$c0%}"
