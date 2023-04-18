


#@echo off

echo "-------------------------------------------"
echo "   _____  _____ _____  _____ _____ _______ "
echo "  / ____|/ ____|  __ \|_   _|  __ \__   __|"
echo " | (___ | |    | |__) | | | | |__) | | |   "
echo "  \___ \| |    |  _  /  | | |  ___/  | |   "
echo "  ____) | |____| | \ \ _| |_| |      | |   "
echo " |_____/ \_____|_|  \_\_____|_|      |_|   "
echo "-------------------------------------------"

# shellcheck disable=SC2121
set compute=/Users/macbookair/university/java/compute/src
set server=/Users/macbookair/university/java/server/src
set client=/Users/macbookair/university/java/client/src

set local_client_directory=/Users/macbookair/folder
set network_folder=/Users/macbookair/



mv /Users/macbookair/university/java/lab_5/Compute.jar %network_folder%compute.jar

echo grant { permission java.security.AllPermission; }; > %local_client_directory%client.policy

echo grant { permission java.security.AllPermission; }; > %network_folder%server.policy

javac -cp %compute% %client%client\*.java
mkdir %network_folder%client
mkdir %network_folder%client\src
xcopy /E /I /Y %client% %network_folder%client\src
del %client%client\*.class
del %network_folder%client\src\client\*.java

javac -cp %compute% %server%engine\*.java