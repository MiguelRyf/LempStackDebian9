#!/bin/bash

# Script author: Miguel Emmara
# Script site: https://www.miguelemmara.me
# One Click LEMP Debian 9 Installation Script
#--------------------------------------------------
# Software version:
# 1. OS: Debian 9 (Stretch) 64 bit
# 2. Nginx: 1.14.2
# 3. MariaDB: 10.3.22-MariaDB-0+deb10u1
# 4. PHP 7: 7.3.14-1~deb10u1
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
