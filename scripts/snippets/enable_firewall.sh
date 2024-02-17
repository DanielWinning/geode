if [ -e /usr/local/bin/geode/scripts/snippets/functions.sh ]
then
  . /usr/local/bin/geode/scripts/snippets/functions.sh
else
  runScriptFromRepository "snippets/functions.sh"
fi

writeText "Enabling firewall and allowing OpenSSH"
sudo ufw --force enable
ufw allow OpenSSH