if [ -e /usr/local/bin/geode/scripts/snippets/functions.sh ]
then
  . /usr/local/bin/geode/scripts/snippets/functions.sh
else
  runScriptFromRepository "snippets/functions.sh"
fi

writeText "Cloning server scripts repository to /usr/local/bin"
git clone https://github.com/DanielWinning/geode.git /usr/local/bin/geode/

writeText "Copying geode command to /bin"
sudo cp /usr/local/bin/geode/bin/geode /bin/geode

writeText "Ensuring geode command can be executed on your system"
sudo chmod -R +x /bin/geode
sudo chmod -R +x /usr/local/bin/geode/scripts/

# Add geode to PATH
writeText "Adding geode to PATH"
echo "export PATH=\$PATH:/bin/geode" >> ~/.bashrc

# Reload bash
writeText "Reloading bash"
source ~/.bashrc