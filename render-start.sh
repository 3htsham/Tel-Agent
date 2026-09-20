#!/bin/sh
set -e

echo "Starting Tel-Agent API..."

python -m api &
API_PID=$!

echo "Waiting for API..."

for i in $(seq 1 30); do
  if wget -q -O /dev/null http://127.0.0.1:38472/health; then
    echo "API is ready."
    break
  fi

  sleep 2
done

echo "Starting Tel-Agent dashboard..."

cd /app/web

exec node server.js
