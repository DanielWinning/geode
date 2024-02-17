. /usr/local/bin/geode/scripts/snippets/functions.sh

writeText "Enabling firewall and allowing OpenSSH"
sudo ufw --force enable
ufw allow OpenSSH