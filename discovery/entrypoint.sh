#!/bin/bash

set -x

if [ -z "${K1_COLONY_API_URL}" ]; then
    echo "K1_COLONY_API_URL NEEDS SETTING"
    exit 1
fi

if [ -z "${K1_COLONY_HARDWARE_ID}" ]; then
    echo "K1_COLONY_HARDWARE_ID NEEDS SETTING"
    exit 1
fi

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
    disk_info=$(lsblk -dpno NAME | awk '{printf "\"%s\",", $1}' | sed 's/,$//')
    echo "[${disk_info}]"
}

# Function to get physical interface info
get_interface_info() {
    interface_info=$(ip -o link show | awk -F': ' 'NR>1{print ",\""$2"\""}')
    echo "["${interface_info:1}"]"
}

# Main function to generate JSON output
generate_json() {
    architecture_info=$(get_architecture_info)
    cpu_info=$(get_cpu_info)
    mem_info=$(get_mem_info)
    disk_info=$(get_disk_info)
    interface_info=$(get_interface_info)

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

  echo "$json_output"

  update_hardware "$json_output"
}

update_hardware() {
  local body=$1
  local response
  local http_code
  local response_body

  response=$(curl --request PUT \
      --url "${K1_COLONY_API_URL}/api/v1/hardwares/${K1_COLONY_HARDWARE_ID}" \
      --header 'Accept: application/json' \
      --header 'Content-Type: application/json' \
      --data "$body" \
      --silent --output - --write-out "\n%{http_code}")

  response_body=$(echo "$response" | head -n -1)
  http_code=$(echo "$response" | tail -n1)

  echo "----------------------------"
  echo "Server ${K1_COLONY_API_URL}/api/v1/hardwares/${K1_COLONY_HARDWARE_ID}"
  echo "body: $body"
  echo "http_code: $http_code"
  echo "response_body: $response_body"
  echo "----------------------------"

  if [[ $http_code -ge 200 && $http_code -le 299 ]]; then
      echo "Request success."
  else
      echo "Error request updating hardware."
      exit 1
  fi
}

# Call the main function to generate JSON output
generate_json
echo "Successfully"

set +x

exit 0
