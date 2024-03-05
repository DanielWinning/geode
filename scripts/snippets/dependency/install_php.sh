echo -e "Installing required packages for web server"
sudo apt install nginx php8.2-fpm php-cli unzip composer nodejs npm php-curl php-gd php-dev php-pear -y

echo -e "Installing xdebug"
sudo pecl install xdebug

echo -e "Enabling xdebug"
sudo echo "zend_extension=xdebug.so" | sudo tee -a /etc/php/8.2/cli/php.ini
sudo echo "xdebug.mode=coverage" | sudo tee -a /etc/php/8.2/cli/php.ini

echo -e "Restarting PHP and Nginx"
sudo systemctl restart php8.2-fpm nginx