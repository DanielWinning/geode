snippets="/usr/local/bin/geode/scripts/snippets";

writeInfoText "Running initial server setup"

test -z "$1" && errorAndExit "Please provide a username for your new sudo user"

username="$1"

"$snippets/disable_kernel_upgrade_notifications.sh"

"$snippets/apt_update.sh"

"$snippets/enable_firewall.sh"

"$snippets/create_sudo_user.sh" "$username"

echo -e "Installing NPM and node"
sudo apt install npm nodejs -y

echo -e "Clearing NPM cache and setting up node for command line usage"
sudo npm cache clean -f
sudo npm install -g n -y
sudo n stable