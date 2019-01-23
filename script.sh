clear
echo "========================"
echo "WP_Creator"
echo "========================"
echo ""
printf 'Installation de la VM, Merci de patienter...'

mkdir wpVagrant
cd wpVagrant
echo "Vagrant.configure('2') do |config|
config.vm.box = 'ubuntu/xenial64'
config.vm.network 'private_network', ip: '192.168.33.10'
config.vm.synced_folder './data', '/var/www/html'
end
" > Vagrantfile
mkdir data
vagrant up > /dev/null
echo "
clear
echo '========================'
echo 'WP_Creator'
echo '========================'
echo ''
printf 'Installation du Wordpress, Merci de patienter...'

# exec > /dev/null 2>&1

cd /var/www/html

sudo apt update 

sudo apt install apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 zip php7.0-zip -y 

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password 0000'

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password 0000'
 
sudo apt-get install -y mysql-server 

mysql -u root -p0000 -e 'create database wordpress;' 

sudo apt install wordpress -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sudo chmod 777 wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

wp core download

wp config create --dbname=wordpress --dbuser=root --dbpass=0000

wp core install --url=192.168.33.10 --title=Example --admin_user=root --admin_password=0000 --admin_email=info@example.com

clear
echo '========================'
echo 'WP_Creator'
echo '========================'
echo ''
printf 'Installation Terminée.\n\nPour utiliser Wordpress, merci de vous rendre sur cet URL :\nhttp://192.168.33.10/wp-admin/ \n\n\n'
">./data/sc2.sh 

vagrant ssh -- -t 'bash /var/www/html/sc2.sh'
