#!/usr/bin/env bash

cpuFreqs=()
totalFreq=0
performance_governor=0

for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
  cpuNum=$(basename "$cpu")

  cpuFreq=$(cat "$cpu/cpufreq/scaling_cur_freq")

  cpuGovernor=$(cat "$cpu/cpufreq/scaling_governor")

  if [[ $cpuGovernor == "performance" ]]; then
    performance_governor=1
  fi

  cpuFreqs+=("$cpuNum: $cpuFreq, Governor: $cpuGovernor")

  totalFreq=$((totalFreq + cpuFreq))
done

avgFreq=$((totalFreq / ${#cpuFreqs[@]}))

class="normal"

if ! systemd-ac-power && [[ $performance_governor -eq 1 ]]; then
  class="high"
fi

format_freq() {
  local freq=$1

  if [[ -z $2 ]]; then
    if (($1 >= 1000000)); then
      formattedFreq=$(awk "BEGIN {printf \"%.1fG\", $freq/1000000}")
    else
      formattedFreq=$(awk "BEGIN {printf \"%.0fM\", $freq/1000}")
    fi
  else
    formattedFreq=$(awk "BEGIN {printf \"%.0f MHz\", $freq/1000}")
  fi

  echo "$formattedFreq"
}

tooltip=""
for i in "${!cpuFreqs[@]}"; do
  cpuInfo="${cpuFreqs[$i]}"
  cpuNum=$(echo "$cpuInfo" | cut -d':' -f1)
  cpuFreqVal=$(echo "$cpuInfo" | cut -d':' -f2 | cut -d',' -f1)
  formatted=$(format_freq "$cpuFreqVal" 1)

  [[ -n "$tooltip" ]] && tooltip+="\n"
  tooltip+="${cpuNum}: ${formatted}"

done

printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' "$(format_freq $avgFreq)" "$class" "$tooltip"
