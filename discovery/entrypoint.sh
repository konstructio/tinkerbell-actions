#!/usr/bin/env bash

echo $K1_COLONY_API_URL
echo $K1_COLONY_HARDWARE_ID

# Function to get architecture info
get_architecture_info() {
    architecture_info=$(lscpu | grep Architecture: | awk '{print $2}')
    echo "$architecture_info"
}

# Function to get number of cpu
get_cpu_info() {
    cpu_info=$(nproc)
    echo "$cpu_info"
}

# Function to get memory info
get_mem_info() {
    mem_info=$(free -m | grep Mem | awk '{print $2}')
    echo "$mem_info"
}

# Function to get physical disk info
get_disk_info() {
    disk_info=$(lsblk -o NAME,TYPE,SIZE | grep disk | awk 'NR>1{if (NR!=1) printf ","; printf "\"%s\"", $1}')
    echo "["${disk_info#,}"]"
}


# Function to get physical interface info
get_interface_info() {
    interface_info=$(ip -o link show | awk -F': ' 'NR>1{print ",\""$2"\""}')
    echo "["${interface_info:1}"]"
}


# Main function to generate JSON output
generate_json() {
    architecture_info=$(get_architecture_info)
    # cpu_info=$(get_cpu_info)
    # mem_info=$(get_mem_info)
    # disk_info=$(get_disk_info)
    # interface_info=$(get_interface_info)

    json_output=$(cat <<EOF
{
    "cpuArchitecture": "$architecture_info",
    "cpuCores": "$cpu_info",
    "memory": "$mem_info",
    "blockDevices": $disk_info,
    "interfaceInfo": $interface_info
}
EOF
)

echo "DEBUG"
echo "$json_output"

# curl --request PUT \
#   --url "${COLONY_API_URL}/api/v1/mock/hardwares/${COLONY_HARDWARE_ID}" \
#   --header 'Accept: application/json' \
#   --header 'Content-Type: application/json' \
#   --data "$json_output"

# }

# Call the main function to generate JSON output
generate_json
