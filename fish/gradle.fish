#!/usr/bin/env fish

# TODO: Add an fzf version as for bash
function _gradle_complete
  set current_dir (basename "$PWD")
  set cache_file "/tmp/completions/cache/gradlew/$current_dir"
  set command (commandline -po)[1]

  if ! find "$cache_file" -newer ./build.gradle.kts 2&> /dev/null
    mkdir -p $(dirname "$cache_file")
    set tasks "$($command tasks | grep -Po "\S+ - (\S+\s?)*")"
    echo "$tasks" | tee "$cache_file"
  end

  cat "$cache_file" | sed 's/ - /\t/'
end


complete --command gradlew --arguments '(_gradle_complete)' --no-files
complete --command gradle --arguments '(_gradle_complete)' --no-files
