if [ -e /usr/local/bin/geode/scripts/snippets/functions.sh ]
then
  . /usr/local/bin/geode/scripts/snippets/functions.sh
else
  runScriptFromRepository "snippets/functions.sh"
fi

writeText "Updating package list"
sudo apt update -y