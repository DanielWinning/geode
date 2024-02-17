defineCommand() {
  local command_name="$1"
  shift
  local script_name="$1"
  shift
  commands["$command_name"]="$command_name"
  scripts["$command_name"]="$script_name"
  command_flags["$command_name"]=$@
}

errorAndExit() {
  writeErrorText "$1"
  exit 1
}

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