writeText "Creating new user with username $1"
adduser --disabled-password --gecos "" --quiet "$1"

writeText "Granting sudo privileges to $1"
usermod -aG sudo "$1"
usermod -aG www-data "$1"
rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"

echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR="tee -a" visudo