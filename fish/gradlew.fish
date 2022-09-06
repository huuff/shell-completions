#!/usr/bin/env fish

function _gradlew_complete
  set current_dir (basename "$PWD")
  set cache_file "/tmp/completions/gradlew/$current_dir"

  if find "$cache_file" -newer ./build.gradle.kts -print
    cat "$cache_file"
  else
    mkdir -p $(dirname "$cache_file")
    set tasks (./gradlew tasks | grep -Po "\w+(?=\W+-\.*)" | tr '\n' ' ')
    echo "$tasks" | tee "$cache_file"
  end
end


complete -c gradlew -a '(_gradlew_complete)' -f
