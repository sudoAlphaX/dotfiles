#!/bin/sh
NAME=archhome

case "$1" in
pre)
  sync # flush dirty pages before I/O freezes
  cryptsetup luksSuspend "$NAME"
  ;;
post)
  cryptsetup luksResume "$NAME" --token-only
  ;;
esac
