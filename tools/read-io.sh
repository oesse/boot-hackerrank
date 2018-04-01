#!/usr/bin/env bash

usage() {
  local exe=$(basename $1)
  echo "Usage: ${exe} MODE IOFILE"
  echo "Or:    ${exe} --help"
  echo "Write the IN or OUT part of IOFILE to stdout"
  echo
  echo "MODE is one of -i|--in or -o|--out."
  exit 0
}

error() {
  local exe=$(basename $1)
  echo "$exe: $2" 1>&2
  echo "Try '$exe --help' for more information." 1>&2
  exit 1
}

[[ $1 == "--help" ]] && usage $0
[[ $# == 2 ]] || error $0 "invalid number of arguments"
case $1 in
  -i|--in)
    in_mode=true
    ;;
  -o|--out)
    in_mode=false
    ;;
  *)
    error $0 "invalid mode"
    ;;
esac
iofile=$2
[[ -r $iofile ]] || error $0 "invalid iofile '$iofile'"

in_marker="=== IN"
out_marker="=== OUT"
if [[ $in_mode == true ]]; then
  sed_script='0,/^'"${in_marker}"'$/d ; /^'"${out_marker}"'$/,$ d'
else
  sed_script='0,/^'"${out_marker}"'$/d'
fi

sed "$sed_script" $iofile
