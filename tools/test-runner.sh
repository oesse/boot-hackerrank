#!/usr/bin/env bash
tools_dir="$(cd "$(dirname "${BASH_SOURCE[0]}"})" && pwd)"
project_root=$tools_dir/..
readio="$tools_dir/read-io.sh"
exe=$1
iofile=$project_root/$2
diff <($exe <($readio -i $iofile)) <($readio -o $iofile)
