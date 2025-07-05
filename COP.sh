#!/bin/bash
HOST=${1:-192.168.1.1}
for port in {20..1024}; do
  nc -zv "$HOST" "$port" 2>&1 | grep -v 'refused'
done
