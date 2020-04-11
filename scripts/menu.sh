#!/bin/bash

# Script author: Miguel Emmara
# Script site: https://www.miguelemmara.me
# Main Menu of the scripts

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

main_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`

clear
# display menu
echo "Server Name - ${grn}$(hostname)${end}"
echo "-------------------------------------------------------------------------"
echo "M A I N - M E N U"
echo "Script By"
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
echo "-------------------------------------------------------------------------"
echo "Choose Your Options"
echo ""
echo "  ${grn}1) DOMAIN MENU >"
echo "  2) DATABASE MENU >"
echo "  3) SHOW CURRENT DOMAIN"
echo "  4) SHOW CURRENT DATABASE"
echo "  5) INSTALL RAINLOOP WEBMAIL"
echo "  6) INSTRALL FILERUN"
echo "  7) CHANGE PORT SSH"
echo "  8) REFRESH SERVER"
echo "  9) CLEAR CACHE RAM"
echo "  10) ${red}RESTART SERVER${end}"
echo "  ${grn}11) EXIT MENU${end}"
echo ""
read -p "Choose your option [1-11]: " choice

  while [ choice != '' ]
  do
    if [[ $choice = "" ]]; then
      exit;
    else
      case $choice in
      1) clear;
      # option_picked "Sub Menu 1";
      sub_menu1;
      ;;

      2) clear;
      # option_picked "Sub Menu 2";
      sub_menu2;
      ;;
  
      3) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/main-menu/showdomain.sh -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      4) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/database-menu/show-databases.sh -O ~/show-databases.sh && dos2unix ~/show-databases.sh && bash ~/show-databases.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      5) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/addons/rainloop.sh -O ~/rainloop.sh && dos2unix ~/rainloop.sh && bash ~/rainloop.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      6) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/addons/filerun.sh -O ~/filerun.sh && dos2unix ~/filerun.sh && bash ~/filerun.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   7) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/main-menu/changeportsshd.sh -O ~/changeportssh.sh && dos2unix ~/changeportssh.sh && bash ~/changeportssh.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   8)     clear;
            systemctl restart php7.0-fpm.service;
            systemctl restart nginx;
            echo "${cyn}Server Refreshed!${end}";
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;  

   9)   clear;
            echo 3 > /proc/sys/vm/drop_caches;
            echo "${cyn}RAM CACHE CLEARED!${end}";
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   10) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian9/master/scripts/main-menu/restartserver.sh -O ~/restartserver.sh && dos2unix ~/restartserver.sh && bash ~/restartserver.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

     11)  clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menuv3.sh${end}";
            exit;
            ;;

        *)
            echo "Error: Invalid option..."
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      main_menu;
            ;;
      esac
    fi
  done
}

clear
main_menu
