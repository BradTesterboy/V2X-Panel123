#!/bin/bash
set -e

export HOME=/home/sulgx

if [ -d /data ]; then
    chown -R sulgx:sulgx /data 2>/dev/null || true
fi

exec gosu sulgx python main.py
