# `shell-completions`
My shell completions. Currently:

* `gradle` and `gradlew`

## Conventions
* Options only after a dash (`-`) has been introduced
* End the cue with `**` to use `fzf` for the completion

## Caveats
* `fish` (and maybe `zsh` too?) only seem to autoload completions with the same filename as the command. Therefore, even if I have completions for `gradlew` inside `gradle.fish`, they won't be autoloaded when completing a `gradlew` command. My solution is to just symlink one to the other.
