snippets="/usr/local/bin/geode/scripts/snippets";
templates="/usr/local/bin/geode/templates";

. "$snippets/functions.sh"

domain_name="$1"
email_address="$2"

noRootAccess

if [ -z "$domain_name" ] || [ -z "$email_address" ]
then
  errorAndExit "Please provide a domain name and an email address for SSL certificate purposes."
fi

"$snippets/apt_update.sh"

"$snippets/enable_firewall.sh"

"$snippets/dependency/install_php.sh"

"$snippets/nginx/create_config.sh" "$domain_name"

sudo unlink /etc/nginx/sites-enabled/default >& /dev/null

echo -e "Creating website directories"
sudo chown -R "$USER":"$USER" /var/www/
sudo mkdir -p /var/www/"$domain_name"/public

sudo cp "$templates/nginx/index.html" "/var/www/$domain_name/public/index.html"

# Install certbot if it isn't already installed
command -v certbot &> /dev/null || "$snippets/dependency/install_certbot.sh"
writeInfoText "Certbot installed"

"$snippets/ssl/generate_cert.sh" "$domain_name" "$email_address"

writeInfoText "SSL certificate generated for $domain_name"
writeSuccessText "Website setup complete. Visit https://$domain_name to view your website."