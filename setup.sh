#!/usr/bin/env bash

sudo -s <<EOF
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8

    apt-get update

    apt-get -y install curl \
      zsh \
      git \
      apt-transport-https \
      ca-certificates \
      software-properties-common \
      xclip

    # Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    apt-get update
    apt-get -y install docker-ce
EOF

# Git setup
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global user.email "p-jerome@hotmail.fr"
git config --global user.name "Jérôme Pogeant"

# Create Projects root dir
mkdir "$(eval echo "~")"/Documents/Projects

# Set zsh as default shell
chsh -s $(which zsh)

# SSH key
ssh-keygen -t rsa -b 4096 -C "p-jerome@hotmail.fr"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub &&
echo "SSH key copied to clipboard"

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"