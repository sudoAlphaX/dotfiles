#!/usr/bin/env sh

preferred="arch"
current=$(uname -r)
device="/dev/mapper/volgroup-cryptarchroot"

if [ -z "$KERNELVERSION" ]; then
  echo "KERNELVERSION is not set. Exiting"
  exit 0
fi

if ! echo "$KERNELVERSION" | grep -q "$preferred" || ! echo "$current" | grep -q "$preferred"; then
  echo "Processing kernel not preferred ($preferred). Exiting"
  exit 0
fi

if [ "$KERNELVERSION" = "$current" ]; then
  echo "Current kernel $current is the same as KERNELVERSION $KERNELVERSION". Exiting.
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
