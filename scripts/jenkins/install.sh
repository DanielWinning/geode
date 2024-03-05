snippets="/usr/local/bin/geode/scripts/snippets";
templates="/usr/local/bin/geode/templates";

. "$snippets/functions.sh"

domain_name="$1"
email_address="$2"

noRootAccess

if [[ $domain_name == "" || $email_address == "" ]]
then
  echo -e "Please provide your domain name (without http/https) and your email address (for SSL expiration emails).\n"
  exit
fi

"$snippets/apt_update.sh"

echo -e "Installing Java Runtime Environment and Java Dev Kit\n"
sudo apt install default-jre default-jdk -y

"$snippets/dependency/install_php.sh"

echo -e "Downloading Jenkins and saving keys\n"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo -e "Installing Jenkins\n"
sudo apt-get install jenkins -y
sudo ufw allow 8080

echo -e "Nginx is not installed. Installing Nginx\n"
sudo apt install nginx -y
sudo ufw allow 'Nginx Full'

echo -e "Copying server config file\n"
sudo cp "$templates/jenkins/nginx.conf" "/etc/nginx/sites-available/$domain_name"
sudo sed -i "s/domain.com/$domain_name/g" /etc/nginx/sites-available/"$domain_name"

sudo mkdir -p /var/www/"$domain_name"/html
sudo chown -R www-data:www-data /var/www/"$domain_name"/html
sudo chmod -R 755 /var/www/"$domain_name"

sudo ln -s "/etc/nginx/sites-available/$domain_name" /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default

sudo sed -i "s/JENKINS_ARGS=\"--webroot=\/var\/cache\/\$NAME\/war --httpPort=\$HTTP_PORT/JENKINS_ARGS=\"--webroot=\/var\/cache\/\$NAME\/war --httpPort=\$HTTP_PORT --httpListenAddress=127.0.0.1/" /etc/default/jenkins

sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --non-interactive --agree-tos -m "$email_address" --nginx -d "$domain_name"

sudo systemctl reload nginx

echo -e "Jenkins installed and available at https://$domain_name. Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword