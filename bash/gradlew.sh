#!/usr/bin/env bash
_gradlew_completions() {
  current_dir=$(basename "$PWD")
  cache_file="/tmp/completions/gradlew/$current_dir"

  # If the results were cached after last buildscript modification
  if [[ $(find "$cache_file" -newer ./build.gradle.kts -print) ]]; then
    # Then just get the completion from there
    # shellcheck disable=2207
    COMPREPLY=($(compgen -W "$(cat "$cache_file")" "${COMP_WORDS[1]}"))
  else
    mkdir -p "$(dirname "$cache_file")"
    tasks=$(./gradlew tasks | grep -Po "\w+(?=\W+-\.*)" | tr '\n' ' ')
    echo "$tasks" > "$cache_file"
    # shellcheck disable=2207
    COMPREPLY=($(compgen -W "$tasks" "${COMP_WORDS[1]}"))
  fi


}

complete -F _gradlew_completions gradlew
