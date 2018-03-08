#!/bin/bash

cd "$(dirname $0)"

KERVER=$(uname -r | grep -o "^4\.")

if [ "$KERVER" != "4." ]; then
  echo "Warning! The linux kernel version must great or equal than 4."
fi

HW=$(uname -m)

if [ "$HW" != "x86_64" ]; then
  echo "Warning! Aion blockchain platform must be running on the 64 bits architecture"
fi

DIST=$(uname -a | grep -o "Ubuntu")

if [ "$DIST" != "Ubuntu" ]; then
  echo "Warning! Aion blockchain is fully compatible with the Ubuntu distribution. Your current system is not Ubuntu distribution. It may have some issues."
fi

MAJVER=$(uname -r | grep -o "[0-9][0-9]" | sed -n 1p)
if [ "$MAJVER" -lt "16" ]; then
  echo "Warning! Aion blockchain is fully compatible with the Ubuntu version 16.04. Your current system is older than Ubuntu 16.04. It may have some issues."
fi

ARG=$@

#if [ "$ARG" == "--close" ]; then
#    PID=$(<./tmp/aion.pid)
#    kill -2 $PID
#    rm -r ./tmp
#    exit 0
#fi

# add execute permission to rt
chmod +x ./rt/bin/*

env EVMJIT="-cache=1" ./rt/bin/java -Xms2g \
        -cp "./lib/*:./lib/libminiupnp/*:./mod/*" org.aion.Aion "$@"
