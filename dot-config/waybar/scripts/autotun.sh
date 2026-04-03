#!/usr/bin/env sh

SHADOWSOCKS_CONFIG_PATH="/etc/shadowsocks-rust/devserver.json"

tun_iface=$(jq -r '.locals[] | select(.protocol=="tun") | .tun_interface_name' <"$SHADOWSOCKS_CONFIG_PATH")

if [ "$1" = "--toggle" ]; then
  if systemctl is-active --quiet autotun@"$tun_iface"; then
    systemctl stop autotun@"$tun_iface"
  else
    systemctl start autotun@"$tun_iface"
  fi
  exit 0
fi

if systemctl is-active --quiet autotun@"$tun_iface"; then
  class="enabled"
else
  class="disabled"
fi

printf '{"text": "󰖂 %s", "class": "%s", "tooltip": "%s"}\n' \
  "$tun_iface" \
  "$class" \
  "$(ip route show default | awk '{printf "%s\\n",$0}' | sed 's/\\n$//')"
