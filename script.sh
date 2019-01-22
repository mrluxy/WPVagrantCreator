spinner() {
    local i sp n
    sp='◷◶◵◴'
    n=${#sp}
    printf ' '
    while sleep 0.3; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}
clear
echo "========================"
echo "WP_Creator"
echo "========================"
echo ""
printf 'Installation de la VM, Merci de patienter...\n\n\n\n\n .. '
spinner &

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
kill "$!" > /dev/null # kill the spinner
clear
echo "
clear

cd /var/www/html

sudo apt update 

sudo apt install apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 zip php7.0-zip -y 

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password 0000'

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password 0000'
 
sudo apt-get install -y mysql-server 

mysql -uroot -p0000 -e 'create database wordpress;' 

">./data/sc2.sh 

vagrant ssh -- -t 'bash /var/www/html/sc2.sh'
