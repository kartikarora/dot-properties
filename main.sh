#!/bin/bash -e

read_properties() {
  local read_result

  local read_path="$1";
  local read_properties="$2";

  if [[ -z "${read_path}" ]]; then
    echo "The path to properties file to read from is empty or unset" >&2
    exit 1
  fi
  if [[ -z "${read_properties}" ]]; then
    echo "The properties you want to read are empty or unset" >&2
    exit 1
  fi

  echo "path to read properties file: $read_path"
  echo "read property keys: $read_properties"

  for read_key in $read_properties; do
    # For lines that have the given property on the left-hand side, remove
    # the property name, the equals and any spaces to get the property value.
    read_result=$(sed -n "/^[[:space:]]*$read_key[[:space:]]*=[[:space:]]*/s/^[[:space:]]*$read_key[[:space:]]*=[[:space:]]*//p" "$read_path")

    echo "value of '$read_key': $read_result"
    # shellcheck disable=SC2001
    echo "$(echo "$read_key" | sed 's/[^A-Za-z0-9_]/-/g')=$read_result" >> $GITHUB_OUTPUT
  done
}

write_properties() {
  local write_path="$1";
  local write_keys_string="$2";
  local write_values_string="$3";

  if [[ -z "${write_path}" ]]; then
    echo "The path to properties file to write to is empty or unset" >&2
    exit 1
  fi
  if [[ -z "${write_keys_string}" ]]; then
    echo "The properties you want to write are empty or unset" >&2
    exit 1
  fi
  if [[ -z "${write_values_string}" ]]; then
    echo "The path to properties values you want to write are empty or unset" >&2
    exit 1
  fi

  mapfile -t write_keys <<<"$write_keys_string"
  mapfile -t write_values <<<"$write_values_string"

  local index=0;
  for i in "${write_keys[@]}"; do
    echo "Writing $i=${write_values[index]}"
    echo -e "\n$i=${write_values[index]}" >> $write_path
    index=$index+1
  done
}

# Read
arg_one="$1"
arg_two="$2"
arg_three="$3"
arg_four="$4"
arg_five="$5"

if [[ -n "${arg_one}" && -n "${arg_two}" ]]; then
  echo "Reading properties"
  read_properties "$1" "$2"
fi

# Write
if [[ -n "${arg_three}" && -n "${arg_four}" && -n "${arg_five}" ]]; then
  echo "Writing properties"
  write_properties "$3" "$4" "$5"
fi