#!/usr/bin/env bash
_gradlew_completions() {
  current_dir=$(basename "$PWD")
  cache_file="/tmp/completions/gradlew/$current_dir"

  # If the results aren't cached, or stale (buildscript was changed after the time it was cached),
  # then, cache it again
  if [[ ! $(find "$cache_file" -newer ./build.gradle.kts -print 2>/dev/null) ]]; then
    mkdir -p "$(dirname "$cache_file")"
    tasks=$(./gradlew tasks | grep -Po "\S+ - (\S+\s?)*" | sed 's/ - /\t/')
    echo "$tasks" > "$cache_file"
  fi

  # Make completions newline separated (that's fish command, and easier to manipulate)
  local IFS=$'\n'
  # shellcheck disable=2207
  COMPREPLY=($(compgen -W "$(cat "$cache_file" | sed 's/\t/ - /')" "${COMP_WORDS[1]}"))

  # If there's only one (i.e. it's gonna accept immediately instead of showing a list)
  if [[ ${#COMPREPLY[*]} -eq 1 ]]; then 
    COMPREPLY=( "${COMPREPLY[0]%% - *}" ) # Then, remove the description (- and everything after it)
  fi

}

complete -F _gradlew_completions gradlew
