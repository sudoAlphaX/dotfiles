#!/usr/bin/env bash

ignored=("zen" "lts")
current=$(uname -r)
device="/dev/mapper/volgroup-cryptarchroot"

if [[ -z $KERNELVERSION ]]; then
  echo "KERNELVERSION is not set"
  exit 0
fi

# If the kernel version is in the ignored list, exit
for ignored_kernel in "${ignored[@]}"; do
  if [[ "$KERNELVERSION" == *"$ignored_kernel"* || "$current" == *"$ignored_kernel"* ]]; then
    echo "Kernel version $KERNELVERSION or current kernel $current is in the ignored list"
    exit 0
  fi
done

if [[ $KERNELVERSION == "$current" ]]; then
  echo "Current kernel $current is the same as KERNELVERSION $KERNELVERSION"
  exit 0
fi

tpm_keys=$(sudo systemd-cryptenroll $device | grep -c "tpm2")

# If there are less than 2 TPM keys, exit
if [ "$tpm_keys" -lt 2 ]; then
  echo "Only $tpm_keys TPM keys found. Not deleting keys"
else
  delete_slot=$(sudo systemd-cryptenroll --no-pager $device | grep "tpm2" | tail -n 1 | awk '{print $1}')
  sudo systemd-cryptenroll --no-pager "$device" --wipe "$delete_slot"
fi
