#!/usr/bin/env bash
_gradlew_completions() {
  IFS=$'\n'
  
  COMPREPLY=($(compgen -W "$(./gradlew tasks |  grep -Po "\S+ - (\S+\s?)*")" "${COMP_WORDS[-1]}" | fzf --height=25% --tiebreak begin))
}

complete -F _gradlew_completions gradlew
