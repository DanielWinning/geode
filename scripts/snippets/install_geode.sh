echo -e "Cloning server scripts repository to /usr/local/bin"
git clone https://github.com/DanielWinning/geode.git /usr/local/bin/geode/

echo -e "Copying geode command to /bin"
sudo cp /usr/local/bin/geode/bin/geode.sh /bin/geode

echo -e "Making geode command executable"
sudo chmod -R +x /bin/geode

# Add geode to PATH
echo -e "Adding geode to PATH"
echo "export PATH=\$PATH:/bin/geode" >> ~/.bashrc

# Reload bash
echo -e "Reloading bash"
source ~/.bashrc