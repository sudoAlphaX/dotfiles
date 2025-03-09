#!/usr/bin/env sh

auto_cpufreq_override_path="/opt/auto-cpufreq/override.pickle"

if [ ! -f "$auto_cpufreq_override_path" ]; then
  pkexec auto-cpufreq --force performance
else
  pkexec auto-cpufreq --force reset
fi
