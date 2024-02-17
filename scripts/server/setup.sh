writeInfoText "Running initial server setup"

test -z "$1" && errorAndExit "Please provide a username for your new sudo user"

./snippets/disable_kernel_upgrade_notifications.sh

./snippets/apt_update.sh

./snippets/enable_firewall.sh

./snippets/create_sudo_user.sh