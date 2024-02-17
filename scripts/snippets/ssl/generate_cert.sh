snippets="/usr/local/bin/geode/scripts/snippets";

. "$snippets/functions.sh"

domain_name="$1"
email_address="$2"

if [ -z "$domain_name" ] || [ -z "$email_address" ]
then
  errorAndExit "Please provide a domain name and an email address for SSL certificate purposes."
fi

echo -e "Generating SSL certificate for $domain_name"
sudo certbot --nginx --non-interactive -m "$email_address" -d "$domain_name" --agree-tos