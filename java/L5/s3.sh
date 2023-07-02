



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




java -cp $server:$network_folder/compute.jar \
 -Djava.rmi.server.codebase=file:///$network_folder/client/src/ \
 -Djava.security.policy=$local_client_directory/server.policy \
 -Djava.rmi.server.hostname=192.168.43.118 \
 engine.ComputeEngine



