#!/bin/bash

# Script author: Miguel Emmara
# Script site: https://www.miguelemmara.me
# One Click LEMP Debian 9 Installation Script
#--------------------------------------------------
# Software version:
# 1. OS: Debian 9 (Stretch) 64 bit
# 2. Nginx: 1.14.2
# 3. MariaDB: 10.3.22-MariaDB-0+deb10u1
# 4. PHP 7: 7.0.14-1~deb10u1
#--------------------------------------------------

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

    # Function update os
    clear
    echo "${grn}Starting update os ...${end}"
    echo ""
    
    sleep 3
    apt update 
    echo ""
    sleep 1

    # Installing UFW Firewall
    echo "${grn}Installing UFW Firewall ...${end}"
    echo "" 
    sleep 2
    apt install ufw 
    echo ""
    sleep 1

    # Allow openSSH UFW
    echo "${grn}Allow openSSH UFW ...${end}"
    echo "" 
    sleep 2
    ufw allow OpenSSH 
    echo ""
    sleep 1

    # Enabling UFW
    echo "${grn}Enabling UFW ...${end}"
    echo ""
    sleep 2
    yes | ufw enable 
    echo "y"
    echo ""
    sleep 1

    # Install MariaDB server
    echo "${grn}Installing MariaDB ...${end}"
    echo "" 
    sleep 2
    MARIADB_VERSION='10.1'
    debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $1" 
    debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $1" 
    apt-get install -qq mariadb-server 
    echo ""
    sleep 1

    echo "${grn}Installing PHP 7.0 ...${end}"
    echo ""
    sleep 2
    apt install php7.0-fpm php-mysql -y 
    apt-get install php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-imap php7.0-cli php7.0-cgi php-pear mcrypt imagemagick libruby php7.0-curl php7.0-intl php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl memcached php-memcache php-imagick php-gettext php7.0-zip php7.0-mbstring memcached php7.0-soap php7.0-fpm php7.0-opcache php-apcu -y 
    echo ""
    sleep 1

    # Install and start nginx
    echo "${grn}Installing NGINX ...${end}"
    echo ""
 
    sleep 3
    apt-get install nginx -y 
    ufw allow 'Nginx HTTP' 
    systemctl start nginx 

        # Configure PHP FPM
    sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/7.0/fpm/php.ini
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.0/fpm/php.ini
    sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.0/fpm/php.ini
    sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/fpm/php.ini
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.0/fpm/php.ini
    sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.0/fpm/php.ini
    echo ""
    sleep 1

    # Installing Memcached
    echo "${grn}Installing Memcached ...${end}"
    echo ""
    sleep 2
    apt install memcached -y 
    echo ""
    sleep 1
    apt install php-memcached -y 
    sleep 1

    # Installing IONCUBE
    echo "${grn}Installing IONCUBE ...${end}"
    echo ""
    sleep 2
    # PHP Modules folder
    MODULES=$(php -i | grep ^extension_dir | awk '{print $NF}')
 
    # PHP Version
    PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
 
    # Download ioncube
    wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
    tar -xvzf ioncube_loaders_lin_x86-64.tar.gz 
    rm -f ioncube_loaders_lin_x86-64.tar.gz 
    # Copy files to modules folder
    sudo cp "ioncube/ioncube_loader_lin_${PHP_VERSION}.so" $MODULES 
    echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >> /etc/php/7.0/fpm/php.ini
    echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >> /etc/php/7.0/cli/php.ini

    rm -rf ioncube
    systemctl restart php7.0-fpm.service 
    systemctl restart nginx 

    # Mcrypt
    apt-get install php-dev libmcrypt-dev php-pear -y 
    pecl channel-update pecl.php.net 
    yes | pecl install channel://pecl.php.net/mcrypt-1.0.2 
    echo "extension=$MODULES/mcrypt.so" >> /etc/php/7.0/fpm/php.ini
    echo "extension=$MODULES/mcrypt.so" >> /etc/php/7.0/cli/php.ini
    systemctl restart php7.0-fpm.service 
    systemctl restart nginx 
    echo ""
    sleep 1

    # Install and start nginx
    echo "${grn}Installing HTOP ...${end}"
    echo ""
    sleep 2
    apt-get install htop 
    echo ""
    sleep 1

    # Install netstat
    echo "${grn}Installing netstat ...${end}"
    echo ""
    sleep 2
    apt install net-tools -y 
    netstat -ptuln 
    echo ""
    sleep 1

    # Install OPENSSL
    echo "${grn}Installing OPENSSL${end}"
    echo ""
    sleep 2
    cd /etc/ssl/certs/
    openssl dhparam -dsaparam -out dhparam.pem 4096 
    cd
    ufw allow 'Nginx Full' 
    ufw delete allow 'Nginx HTTP' 
    echo ""
    sleep 1

    # Install AB BENCHMARKING TOOL
    echo "${grn}Installing AB BENCHMARKING TOOL ...${end}"
    echo ""
    sleep 2
    apt-get install apache2-utils -y 
    echo ""
    sleep 1

    # Install ZIP AND UNZIP
    echo "${grn}Installing ZIP AND UNZIP ...${end}"
    echo ""
    sleep 2
    apt-get install unzip 
    apt-get install zip 
    echo ""
    sleep 1

    # Install FFMPEG and IMAGEMAGICK
    echo "${grn}Installing FFMPEG AND IMAGEMAGICK...${end}"
    echo ""
    sleep 2
    apt-get install imagemagick -y 
    apt-get install ffmpeg -y 
    echo ""
    sleep 1

    # Config to make PHP-FPM working with Nginx
    echo "${grn}Configuring to make PHP-FPM working with Nginx ...${end}"
    echo ""
    sleep 2
    rm -rf /etc/nginx/nginx.conf 
    cd /etc/nginx/
    wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/nginx.conf -O nginx.conf 
    dos2unix /etc/nginx/nginx.conf 
    cd
    echo ""
    sleep 1

    # Change Login Greeting
    echo "${grn}Change Login Greeting ...${end}"
    echo ""
    sleep 2
    cat > .bashrc << EOF
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo " ######################## FULL INSTRUCTIONS GO TO MIGUELEMMARA.ME ####################### "
echo ""
echo " __  __ _                  _   ______"                                    
echo "|  \/  (_)                | | |  ____|                                    "
echo "| \  / |_  __ _ _   _  ___| | | |__   _ __ ___  _ __ ___   __ _ _ __ __ _ "
echo "| |\/| | |/ _  | | | |/ _ \ | |  __| | '_   _ \| '_   _ \ / _  | '__/ _  |"
echo "| |  | | | (_| | |_| |  __/ | | |____| | | | | | | | | | | (_| | | | (_| |"
echo "|_|  |_|_|\__, |\__,_|\___|_| |______|_| |_| |_|_| |_| |_|\__,_|_|  \__,_|"
echo "           __/ |"                                                        
echo "          |___/"
echo ""
./menu.sh
EOF
echo ""
sleep 1

    # PHP POOL SETTING
    echo "${grn}Configuring to make PHP-FPM working with Nginx ...${end}"
    echo ""
 
    sleep 3
    php7_dotdeb="https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/php7dotdeb"
    wget -q $php7_dotdeb -O /etc/php/7.0/fpm/pool.d/$domain.conf 
    sed -i "s/domain.com/$domain/g" /etc/php/7.0/fpm/pool.d/$domain.conf
    echo "" >> /etc/php/7.0/fpm/pool.d/$domain.conf
    dos2unix /etc/php/7.0/fpm/pool.d/$domain.conf 
    service php7.0-fpm reload 

        # Restart nginx and php-fpm
    echo "Restart Nginx & PHP-FPM ..."
    echo ""
    sleep 1
    systemctl restart nginx 
    systemctl restart php7.0-fpm.service 

     # Menu Script
    cd
    wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/menu.sh -O menu.sh 
    dos2unix menu.sh 
    chmod +x menu.sh

    # Success Prompt
    clear
    echo "LEMP Auto Installer BY Miguel Emmara `date`"
    echo "*******************************************************************************************"
    echo "              *   *    *****    *         ***      ***     *   *    *****     "
    echo "              *   *    *        *        *   *    *   *    *   *    *     "
    echo "              *   *    *        *        *        *   *    ** **    *     "
    echo "              *   *    ****     *        *        *   *    * * *    ****  "
    echo "              * * *    *        *        *        *   *    *   *    *     "
    echo "              * * *    *        *        *   *    *   *    *   *    *     "
    echo "               * *     *****    *****     ***      ***     *   *    ***** "
    echo ""

    echo "                        *****     *** "
    echo "                      *      *   *    "
    echo "                      *      *   *    "
    echo "                      *      *   *    "
    echo "                      *      *   *    "
    echo "                      *      *   *    "
    echo "                      *       *** "
        echo ""

    echo " *   *    *****     ***     *   *    *****    *        *****    *****     ***     *   * "
    echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
    echo " ** **      *      *        *   *    *        *          *      *        *        *   * "
    echo " * * *      *      * ***    *   *    ****     *          *      ****     *        ***** "
    echo " *   *      *      *   *    *   *    *        *          *      *        *        *   * "
    echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
    echo " *   *    *****     ***      ***     *****    *****      *      *****     ***     *   * "
    echo "********************* OPEN MENU BY TYPING ${grn}./menu.sh${end} ******************************"
    echo ""

rm -f /root/lemp-debian-9.sh
exit
