#!/bin/bash

# globals
VERSION=0.0.1
COMMAND="$1"

usage () {
  echo "digest [command] [-hV]"
  echo
  echo "Options:"
  echo "  -h|--help      Print this help dialogue and exit"
  echo "  -V|--version   Print the current version and exit"
  echo
  echo "Commands:"
  echo "  base64:encode  Base64 text encode"
  echo "  base64:decode  Base64 text decode"
}

base64_encode() {
  local value="$1"
  printf "%s" "$value" | base64 | tr -d '\r\n'
}

base64_decode() {
  local value="$1"
  printf "%s" "$value" | base64 -d
}

digest () {
  for opt in "${@}"; do
    case "$opt" in
      -h|--help)
        usage
        return 0
        ;;
      -V|--version)
        echo "$VERSION"
        return 0
        ;;
    esac
  done

  # execute commands
  case $COMMAND in
    base64:encode)
      shift
      base64_encode "$1"
      return 0
      ;;
    base64:decode)
      shift
      base64_decode "$1"
      return 0
      ;;
    *)
      usage
      return 0
      ;;
  esac
}

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  export -f digest
else
  digest "${@}"
  exit $?
fi


