#!/usr/bin/env bash
_gradlew_completions() {
  current_dir=$(basename "$PWD")
  cache_file="/tmp/completions/gradlew/$current_dir"

  # If the results aren't cached, or stale (buildscript was changed after the time it was cached),
  # then, cache it again
  if [[ ! $(find "$cache_file" -newer ./build.gradle.kts -print 2>/dev/null) ]]; then
    mkdir -p "$(dirname "$cache_file")"
    tasks=$(./gradlew tasks | grep -Po "\w+(?=\W+-\.*)")
    echo "$tasks" > "$cache_file"
  fi

  # shellcheck disable=2207
  COMPREPLY=($(compgen -W "$(cat < "$cache_file" | tr '\n' ' ')" "${COMP_WORDS[1]}"))

}

complete -F _gradlew_completions gradlew
