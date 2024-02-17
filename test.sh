. ./scripts/snippets/functions.sh

defineCommand setup "setup.sh"

isValidCommand "$1" || errorAndExit "Invalid command: $1"

runCommandWithArgs "$@"