##########################################################################
# Linux setup                                                            #
##########################################################################


##### Set up Git? #####
## Setting up Git
read -p "Set up Git? [y/n] " git
if [[ $git = y ]] ; then
	read -p "Enter name: " name
	read -p "Enter email: " email
fi

##### Add a serial to VMWare? #####
## Setting up Git
read -p "Install VMWare? [y/n] " vmware_install_yn
if [[ $vmware_install_yn = y ]] ; then
	read -p "Add a serial to VMWare? [y/n] " vmware_serial_yn
	if [[ $vmware_serial_yn = y ]] ; then
		read -p "Enter serial: " vmserial
	fi
fi


##### Adding sources to apt #####

## Atom Editor (https://flight-manual.atom.io/getting-started/sections/installing-atom/#platform-linux)
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

## Balena Etcher (https://www.balena.io/etcher/)
#echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

## Signal desktop (https://signal.org/desktop)
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

## Docker Community Edition (https://docs.docker.com/install/linux/docker-ce/ubuntu/)
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable"

## Wireguard (https://github.com/trailofbits/algo/blob/master/docs/client-linux-wireguard.md)
# sudo add-apt-repository ppa:wireguard/wireguard

##### Updating apt & system #####
sudo apt update && sudo apt full-upgrade -y

###### Installing programmes (from repo) #####
## apt install

sudo apt install atom -y # from custom repo
#sudo apt install balena-etcher-electron -y
sudo apt install curl -y
#sudo apt install cherrytree -y # Notetaking
sudo apt install dislocker -y # read/write bitlocker encrypted drives
#sudo apt install docker-ce docker-ce-cli containerd.io -y # from custom repo
sudo apt install evince -y # PDF viewer
#sudo apt install gedit -y
sudo apt install gparted -y
sudo apt install htop -y
sudo apt install nmap -y
#sudo apt install notable -y
sudo apt install powerline fonts-powerline powerline-gitstatus -y
sudo apt install signal-desktop -y # from custom repo
sudo apt install torbrowser-launcher -y
sudo apt install traceroute -y
sudo apt install transmission -y
sudo apt install vim -y
sudo apt install vlc -y
#sudo apt install wireguard openresolv -y # From custom repo
sudo apt install wireshark -y
sudo apt install whois -y
sudo apt install xclip -y
sudo apt install youtube-dl -y

##### Installing programmes (other sources) #####
## VMware
if [[ $vmware = y ]] ; then
	wget --directory-prefix=$HOME/Downloads/ --content-disposition --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getworkstation-linux
	sudo sh $HOME/Downloads/VMware-Workstation*.bundle --console --required --eulas-agreed --set-setting vmware-workstation serialNumber "$vmserial"
elif [[ $vmware = n ]]; then
	wget --directory-prefix=$HOME/Downloads/ --content-disposition --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getworkstation-linux
	sudo sh $HOME/Downloads/VMware-Workstation*.bundle --console --required --eulas-agreed
fi

# Install Vundle (VIM plugin manager)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall # Install plugins

##### Configuring Git #####
if [[ $git = y ]] ; then
	#read -p "Enter name: " name
	# Set credentials to use with git
	git config --global user.name "$name"
	#read -p "Enter email: " email
	git config --global user.email "$email"
	# Generate keys
	ssh-keygen -t rsa -b 4096 -C "$email"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
	xclip -sel clip < ~/.ssh/id_rsa.pub
	echo ""
	echo "********************************************"
	echo "*                                          *"
	echo "* Go go https://github.com/settings/keys   *"
	echo "* and add new sshkey (copied to clipboard) *"
	echo "*                                          *"
	echo "********************************************"
	echo ""
	read -p "Press [Enter] to continue..."
fi

##### Post installation cleanup #####
sudo apt autoremove -y

##########################################################################
# Symlinking dotfiles                                                    #
##########################################################################

##### Backup existing dotfiles #####
CURRENTDIR=$(pwd -L)
mkdir $CURRENTDIR/dotbackup/
mv ~/.bash_aliases $CURRENTDIR/dotbackup/.bash_aliases.old
mv ~/.bash_logout $CURRENTDIR/dotbackup/.bash_logout.old
mv ~/.bash_profile $CURRENTDIR/dotbackup/.bash_profile.old
mv ~/.bash_prompt $CURRENTDIR/dotbackup/.bash_prompt.old
mv ~/.bashrc $CURRENTDIR/dotbackup/.bashrc.old
mv ~/.vimrc $CURRENTDIR/dotbackup/.vimrc.old

##### Symlinking new dotfiles #####
CURRENTDIR=$(pwd -L)
ln -s $CURRENTDIR/.bash_aliases ~/.bash_aliases
ln -s $CURRENTDIR/.bash_logout ~/.bash_logout
ln -s $CURRENTDIR/.bash_profile ~/.bash_profile
ln -s $CURRENTDIR/.bash_prompt ~/.bash_prompt
ln -s $CURRENTDIR/.bashrc ~/.bashrc
ln -s $CURRENTDIR/.vimrc ~/.vimrc
