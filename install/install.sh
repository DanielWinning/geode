# Set the current directory to the directory of the script
directory=$(dirname "$0")
parent_directory="$(dirname "$directory")"
snippets="$parent_directory/scripts/snippets"

# Load helper functions
. "$parent_directory/scripts/snippets/functions.sh"

# Set username
username=$1

if [ "$username" == "" ]
then
  errorAndExit "Username is required"
fi

# Exit if the OS is not supported
validateOperatingSystemOrExit

#Disable Kernel upgrade notifications
"$snippets/disable_kernel_upgrade_notifications.sh"
writeInfoText "Kernel upgrade notifications disabled"

# Update package manager
"$snippets/update_packages.sh"
writeInfoText "Package list updated"

# Install Git
"$snippets/install_git.sh"
writeInfoText "Git installed"

# Create new user
"$snippets/create_sudo_user.sh" "$username"
writeInfoText "User created"

# Install Geode
"$snippets/install_geode.sh"
writeInfoText "Geode installed"

# Enable firewall and allow OpenSSH
"$snippets/enable_firewall.sh"
writeInfoText "Firewall enabled and OpenSSH allowed"

writeSuccessText "Setup complete. Please exit your server and connect again with $username"