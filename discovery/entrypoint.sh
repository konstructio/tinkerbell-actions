#!/bin/bash

set -x

if [ -z "${K1_COLONY_HARDWARE_ID}" ]; then
    echo "K1_COLONY_HARDWARE_ID NEEDS SETTING"
    exit 1
fi

if [ -z "${COLONY_API_KEY}" ]; then
    echo "COLONY_API_KEY NEEDS SETTING"
    exit 1
fi

update_hardware() {
  output=$(./colony-scout discovery \
    --token="${COLONY_API_KEY}" \
    --hardware-id="${K1_COLONY_HARDWARE_ID}" 2>&1)

  exit_status=$?

  if [[ $exit_status -eq 0 ]]; then
        echo "Request success."
    else
        echo "Error request updating hardware."
        echo "Output: $output"
        exit 1
    fi
}

update_hardware

set +x

exit 0
