


# shellcheck disable=SC2121
export compute="/Users/macbookair/Downloads/L5/compute/src/"

# shellcheck disable=SC2121
export server="/Users/macbookair/Downloads/L5/server/src/"
# shellcheck disable=SC2121
export client="/Users/macbookair/Downloads/L5/client/src/"

# shellcheck disable=SC2121
export local_client_directory="/Users/macbookair/Downloads/L5/work/"
# shellcheck disable=SC2121
export network_folder="/Users/macbookair/Desktop/work/"

# shellcheck disable=SC2121
export root="%~dp0"
# shellcheck disable=SC2164
cd "${compute}"
javac compute/*.java
jar cvf compute.jar compute/*.class
# shellcheck disable=SC2164
cd "${root}"


mv "${compute}"compute.jar "${local_client_directory}"compute.jar

mv "${local_client_directory}"compute.jar "${network_folder}"compute.jar

echo "grant {permission java.security.AllPermission;};" > "${local_client_directory}client.policy"

echo "grant permission java.security.AllPermission" > "${local_client_directory}"server.policy

javac -cp "${compute}" "${client}"client/*.java
mkdir "${network_folder}"client
mkdir "${network_folder}"client/src
echo "mv1"
cp -r "${client}" "${network_folder}"client/src
echo "mv2"
rm "${client}"client/*.class
rm "${local_client_directory}"client/src/client/*.java
javac -cp "${compute}" "${server}"engine/*.java

echo "javac srv"
