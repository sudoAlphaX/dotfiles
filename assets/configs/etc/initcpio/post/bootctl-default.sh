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

echo "Setting $KERNELVERSION as default"
sudo bootctl set-default "$(cat /etc/machine-id)-$KERNELVERSION.conf"
