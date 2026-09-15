#!/usr/bin/env bash
# prints how many times each log type appears.

declare -A error_counts
LOG_FILE="app.log"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: Log file not found: $LOG_FILE"
  exit 1
fi

while IFS= read -r line; do
  log_type=$(echo "$line" | awk -F: '{print $1}')

  if [[ -z "$log_type" ]]; then
    continue
  fi

  error_counts["$log_type"]=$(( ${error_counts["$log_type"]} + 1 ))
done < "$LOG_FILE"

echo "--- Log Analysis Report ---"
for type in "${!error_counts[@]}"; do
  echo "$type: ${error_counts[$type]}"
done