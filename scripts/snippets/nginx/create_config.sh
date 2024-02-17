domain_name="$1"
templates="/usr/local/bin/geode/templates"
snippets="/usr/local/bin/geode/scripts/snippets"

. "$snippets/functions.sh"

test -z "$domain_name" && errorAndExit "Please provide a domain name"

echo -e "Downloading and generating website config"
sudo cp "$templates/nginx/nginx.conf" "/etc/nginx/sites-available/$domain_name"
sudo sed -i "s/domain.com/$domain_name/" /etc/nginx/sites-available/"$domain_name"
sudo sed -i "s/www.domain.com/$domain_name/" /etc/nginx/sites-available/"$domain_name"
sudo ln -s /etc/nginx/sites-available/"$domain_name" /etc/nginx/sites-enabled/

echo -e "Creating website directories"
sudo chown -R "$USER":"$USER" /var/www/
sudo mkdir -p /var/www/"$domain_name"/public

sudo bash -c "/usr/local/bin/geode/templates/nginx/index.html > /var/www/$domain_name/public/index.html"