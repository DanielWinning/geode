# The rest of the package won't be available on the installing machine,
# so we need to use the scripts remotely
runScriptFromRepository() {
  local repositoryUrl="https://raw.githubusercontent.com/DanielWinning/geode/main/scripts"
  local scriptName="$1"

  source /dev/stdin <<< "$(curl -s "$repositoryUrl/$scriptName")"
}

runScriptFromRepository "snippets/functions.sh"

# Exit if not running on Linux
validateOperatingSystemOrExit

command -v git &> /dev/null || runScriptFromRepository "snippets/dependency/install_git.sh"

runScriptFromRepository "snippets/install_geode.sh"

cleanupInstaller

writeSuccessText "Geode installed and ready to use. Optional: Exit your SSH session and reconnect to apply bash prompt colour changes."