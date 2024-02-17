######################
## Global Variables ##
######################
declare -A commands

##############
## Commands ##
##############
defineCommand() {
  local command_name="$1"
  local script_name="$2"
  commands["$command_name"]="$script_name"
}

listCommands() {
  for command in "${!commands[@]}"
  do
    echo "$command - ${commands[$command]}"
  done
}

isValidCommand() {
  local command_name="$1"
  test -n "${commands[$command_name]}"
  return $?
}

runCommandWithArgs() {
  local command_name="$1"
  local script_name="${commands[$command_name]}"
  shift
  . "/usr/local/bin/geode/scripts/$script_name" "$@"
  #. "C:/Development/Packages/geode/scripts/$script_name" "$@"
}

################
## Validators ##
################
validateOS() {
  if [ "$OSTYPE" == "linux-gnu" ]
  then
    return 0;
  else
    return 1;
  fi
}

validateOperatingSystemOrExit() {
  if ! validateOS
  then
    errorAndExit "This script is only supported on Linux"
  fi
}

#######################
## Output Formatters ##
#######################
errorAndExit() {
  writeErrorText "$1"
  exit 1
}

writeText() {
  echo -e "\x1b[95m$1\x1b[0m"
}

writeErrorText() {
  echo -e "\x1b[31mError: $1\x1b[0m"
}

writeSuccessText() {
  echo -e "\x1b[32m$1\x1b[0m"
}

writeWarningText() {
  echo -e "\x1b[33mWarning: $1\x1b[0m"
}

writeInfoText() {
  echo -e "\x1b[34m$1\x1b[0m"
}

###############
## Installer ##
###############
cleanupInstaller() {
  rm -rf /usr/local/bin/geode/install
  rm -rf /usr/local/bin/geode/scripts/snippets/install_geode.sh
}