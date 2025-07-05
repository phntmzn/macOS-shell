#!/bin/bash
SUBNET=${1:-192.168.1}
for i in {1..254}; do
  ping -c 1 -W 1 "$SUBNET.$i" &> /dev/null && echo "Host $SUBNET.$i is up"
done
