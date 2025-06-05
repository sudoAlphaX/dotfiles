#!/usr/bin/env sh

auto_cpufreq_override_path="/opt/auto-cpufreq/override.pickle"

if [ ! -f "$auto_cpufreq_override_path" ]; then
  if systemd-ac-power; then
    pkexec auto-cpufreq --force powersave
  else
    pkexec auto-cpufreq --force performance
  fi
else
  pkexec auto-cpufreq --force reset
fi
