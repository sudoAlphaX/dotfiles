#!/usr/bin/env sh

CPUFREQ_OVERRIDE_FILE=/opt/auto-cpufreq/override.pickle
PERFORMANCE_MODE_SECONDS=60

CPUFREQ_PERFORMANCE_MODE="performance"
CPUFREQ_POWERSAVE_MODE="powersave"

if [ ! -f $CPUFREQ_OVERRIDE_FILE ]; then
  # In default mode
  cpufreq-force --performance
  sleep $PERFORMANCE_MODE_SECONDS
  cpufreq-force --reset

elif grep $CPUFREQ_POWERSAVE_MODE $CPUFREQ_OVERRIDE_FILE; then
  cpufreq-force --performance
  sleep $PERFORMANCE_MODE_SECONDS
  cpufreq-force --powersave
fi
