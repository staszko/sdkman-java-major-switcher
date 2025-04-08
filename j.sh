#!/usr/bin/env bash

function print_usage() {
    VERSIONS=$(\ls $SDKMAN_DIR/candidates/java | \grep -v current | \awk -F'.' '{print $1}' | \sort -nr | \uniq)
    CURRENT=$(\basename $(\readlink $JAVA_HOME || \echo $JAVA_HOME) | \awk -F'.' '{print $1}')
    \echo "Available versions: "
    \echo "$VERSIONS"
    \echo "Current: $CURRENT"
    \echo "Usage: j <java_version> [distibution_name_suffix]"
}

if [[ $# -eq 1 || $# -eq 2 ]]; then
  VERSION_NUMBER=$1
  SUFFIX="${2:-}"
  IDENTIFIER=$(\ls $SDKMAN_DIR/candidates/java | \grep -v current | \grep "^$VERSION_NUMBER." | \awk -v sfx="$SUFFIX" '{ if ($0 ~ sfx"$") print "2"$0; else print "1"$0 }' | sort -r | cut -c2- | \head -n 1)
  sdk use java $IDENTIFIER
else
  print_usage
fi
