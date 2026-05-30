#!/usr/bin/sh

end=$(($(date +%s) + 10))
while [ "$(date +%s)" -lt "$end" ]; do
  ping -c1 -W1 1.1.1.1 >/dev/null 2>&1 && exit 0
done
exit 0
