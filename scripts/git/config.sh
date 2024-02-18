snippets="/usr/local/bin/geode/scripts/snippets";

. "$snippets/functions.sh"

username="$1"
email_address="$2"

noRootAccess
runServerSetupFirst

if [ -z "$username" ] || [ -z "$email_address" ]
then
  errorAndExit "Please provide a username and an email address."
fi

git config --global user.name "$username"
git config --global user.email "$email_address"