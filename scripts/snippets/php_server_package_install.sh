echo -e "Installing required packages for web server"
sudo apt install nginx php8.2-fpm php-cli unzip composer nodejs npm php-curl php-gd -y

echo -e "Allow Nginx through firewall"
sudo ufw allow 'Nginx Full'