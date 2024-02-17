. /usr/local/bin/geode/scripts/snippets/functions.sh

writeText "Disabling Kernel upgrade notifications"
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf