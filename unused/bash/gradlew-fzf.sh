#!/usr/bin/env bash
# TODO: Use cache
# TODO: Remove description from completion
# TODO: Find out what warning 2207 means
_gradlew_completions() {
  IFS=$'\n'

  last_word="${COMP_WORDS[-1]}"
  starting_options=($(compgen -W "$(./gradlew tasks |  grep -Po "\S+ - (\S+\s?)*")" "$last_word"))

  if [[ ${#starting_options[*]} -eq 1 ]]; then
    COMPREPLY=("${starting_options[0]}")
  else
    chosen_option=$(echo "${starting_options[*]}" \
      | fzf --query="$last_word" \
            --height=25% \
            --tiebreak=begin)
    COMPREPLY=("$chosen_option")
  fi
}

complete -F _gradlew_completions gradlew
