#!/bin/bash
IFACE=${1:-en0}
sudo tcpdump -i "$IFACE" -n -v -w capture.pcap
