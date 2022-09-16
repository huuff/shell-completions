# TODO: Add an fzf version as for bash
function _gradle_complete
  set cache_file "/tmp/completions/cache/gradle$PWD"
  set command (commandline -po)[1]

  if ! find "$cache_file" -newer "$PWD/build.gradle.kts" 2&> /dev/null
    mkdir -p $(dirname "$cache_file")
    set tasks "$($command tasks | grep -Po "\S+ - (\S+\s?)*")"
    echo "$tasks" | tee "$cache_file"
  end

  cat "$cache_file" | sed 's/ - /\t/'
end


complete --command gradlew --command gradle --arguments '(_gradle_complete)' --no-files
