. /usr/local/bin/geode/scripts/snippets/functions.sh

if usernameExists "$1"
then
  errorAndExit "User $1 already exists. Please provide a different username."
fi

writeText "Creating new user with username $1"
adduser --disabled-password --gecos "" --quiet "$1"

writeText "Granting sudo privileges to $1"
usermod -aG sudo "$1"
usermod -aG www-data "$1"

writeText "Copying SSH keys and bash settings to new user"
rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"
rsync --archive --chown="$1":"$1" ~/.bashrc /home/"$1"

echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR="tee -a" visudo