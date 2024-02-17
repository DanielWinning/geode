# Set the current directory to the directory of the script
directory=$(dirname "$0")
parent_directory="$(dirname "$directory")"
snippets="$parent_directory/scripts/snippets"

## Load helper functions
#. "$parent_directory/scripts/snippets/functions.sh"

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
writeErrorText() {
  echo -e "\x1b[31mError: $1\x1b[0m"
}
writeInfoText() {
  echo -e "\x1b[34m$1\x1b[0m"
}
writeSuccessText() {
  echo -e "\x1b[32m$1\x1b[0m"
}

# Set username
username=$1

if [ "$username" == "" ]
then
  errorAndExit "Username is required"
fi

# Exit if the OS is not supported
validateOperatingSystemOrExit

##Disable Kernel upgrade notifications
#"$snippets/disable_kernel_upgrade_notifications.sh"
#writeInfoText "Kernel upgrade notifications disabled"

## Update package manager
#"$snippets/update_packages.sh"
#writeInfoText "Package list updated"

# Install Git
echo -e "Installing Git"
sudo apt install git -y

# Install Geode
echo -e "Cloning server scripts repository to /usr/local/bin"
git clone https://github.com/DanielWinning/geode.git /usr/local/bin/geode/

echo -e "Copying geode command to bin"
sudo cp /usr/local/bin/geode/geode.sh /bin/geode

echo -e "Making geode command executable"
sudo chmod -R +x /bin/geode

# Add geode to PATH
echo -e "Adding geode to PATH"
echo "export PATH=\$PATH:/bin/geode" >> ~/.bashrc

# Reload bash
echo -e "Reloading bash"
source ~/.bashrc

writeInfoText "Geode installed"

## Create new user
#"$snippets/create_sudo_user.sh" "$username"
#writeInfoText "User created"
#
## Enable firewall and allow OpenSSH
#"$snippets/enable_firewall.sh"
#writeInfoText "Firewall enabled and OpenSSH allowed"
#
#writeSuccessText "Setup complete. Please exit your server and connect again with $username"