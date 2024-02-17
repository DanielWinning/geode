domain_name="$1"
templates="/usr/local/bin/geode/templates"

test -z "$domain_name" && errorAndExit "Please provide a domain name"

echo -e "Creating systemd service"
sudo cp "$templates/nginx/nginx.service" "/etc/systemd/system/$domain_name.service"
sudo sed -i "s/domain.com/$domain_name/g" "/etc/systemd/system/$domain_name.service"

echo -e "Enabling and starting website as a service"
sudo systemctl enable "$domain_name"
sudo systemctl start "$domain_name"