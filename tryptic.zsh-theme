tryptic::initialize() {
  # Returns the dirty status and branch name of the working repository.
  tryptic::git_custom_status() {
    local cb=$(current_branch)
    if [ -n "$cb" ]; then
      echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
  }

  # Returns the number of unstaged changes in the working repository.
  tryptic::unstaged_change_count() {
    local cb=$(current_branch)
    if [ -n "$cb" ]; then
      git status --short | wc -l | sed -e 's/ //g' -e 's/ *$//g'
    fi
  }

  # Styles the appearence of the git prompt. Used by `git_custom_status`.
  tryptic::style_git_prompt() {
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[red]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  }

  # Styles the appearence of clean/dirty status. Used by `parse_git_dirty`.
  tryptic::style_clean_and_dirty_status() {
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}*%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
  }

  # Configure the Right Prompt to display Git status.
  tryptic::initialize_right_prompt() {
    RPS1='$(tryptic::git_custom_status):%{$fg[magenta]%}$(tryptic::unstaged_change_count)%{$reset_color%} $EPS1'
  }

  # Configure the Prompt to display Git status.
  tryptic::initialize_prompt() {
    PROMPT='▲  %{$fg[white]%}%~% %(?.%{$fg[magenta]%}.%{$fg[magenta]%})%B%b '
  }

  tryptic::style_git_prompt
  tryptic::style_clean_and_dirty_status
  tryptic::initialize_right_prompt
  tryptic::initialize_prompt
}

tryptic::initialize
