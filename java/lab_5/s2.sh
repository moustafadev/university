@echo off

echo "-------------------------------------------"
echo "   _____  _____ _____  _____ _____ _______ "
echo "  / ____|/ ____|  __ \|_   _|  __ \__   __|"
echo " | (___ | |    | |__) | | | | |__) | | |   "
echo "  \___ \| |    |  _  /  | | |  ___/  | |   "
echo "  ____) | |____| | \ \ _| |_| |      | |   "
echo " |_____/ \_____|_|  \_\_____|_|      |_|   "
echo "-------------------------------------------"

set compute=/Users/macbookair/university/java/compute/src
set server=/Users/macbookair/university/java/server/src
set client=/Users/macbookair/university/java/client/src

set local_client_directory=/Users/macbookair/folder
set network_folder=/Users/macbookair/

cd /Users/macbookair/university/java/compute/src
rmiregistry

