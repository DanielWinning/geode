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

# Install Git
echo -e "Installing Git"
sudo apt install git -y

# Install Geode
echo -e "Cloning server scripts repository to /usr/local/bin"
git clone https://github.com/DanielWinning/geode.git /usr/local/bin/geode/

echo -e "Copying geode command to bin"
sudo cp /usr/local/bin/geode/bin/geode /bin/geode

echo -e "Making geode command executable"
sudo chmod -R +x /bin/geode

# Add geode to PATH
echo -e "Adding geode to PATH"
echo "export PATH=\$PATH:/bin/geode" >> ~/.bashrc

# Reload bash
echo -e "Reloading bash"
source ~/.bashrc

writeSuccessText "Geode installed"