snippets="/usr/local/bin/geode/scripts/snippets";

. "$snippets/functions.sh"

domain_name="$1"
email_address="$2"

noRootAccess

if [ -z "$domain_name" ] || [ -z "$email_address" ]
then
  errorAndExit "Please provide a domain name and an email address for SSL certificate purposes."
fi

"$snippets/nginx/create_config.sh" "$domain_name"

"$snippets/ssl/generate_cert.sh" "$domain_name" "$email_address"