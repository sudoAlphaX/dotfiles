#!/usr/bin/env sh

if systemd-ac-power; then
  refresh-hyprate low
else
  refresh-hyprate high
fi
