#!/bin/bash

sudo apt-get update 
sudo apt-get upgrade -y


echo "##########"
echo "### Install curl openssh-server git aptitude"
echo "##########"

sudo apt-get install curl openssh-server git aptitude -y

# Install Google Chrome 
echo "##########"
echo "### Install Google Chrome"
echo "##########"
curl -O -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install -y
sudo rm google-chrome-stable_current_amd64.deb


# Install Atom
echo "##########"
echo "### Install Atom"
echo "##########"
sudo add-apt-repository ppa:webupd8team/atom -y
sudo apt-get update
sudo apt-get install atom -y


# Install Telegram
echo "##########"
echo "### Install Telegram"
echo "##########"
sudo add-apt-repository ppa:atareao/telegram -y
sudo apt-get update
sudo apt-get install telegram -y

# Install Java
echo "##########"
echo "### Install Java"
echo "##########"
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer -y

# Install Adobe fonts : Source Code Pro
echo "##########"
echo "### Install Fonts: Source Code Pro"
echo "##########"
mkdir /tmp/adodefont
cd /tmp/adodefont
wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
unzip 1.050R-it.zip 
mkdir -p ~/.fonts
cp source-code-pro-2.030R-ro-1.050R-it/OTF/*.otf ~/.fonts/
fc-cache -f -v
