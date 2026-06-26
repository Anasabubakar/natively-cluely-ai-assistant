#!/bin/bash
# Natively Linux Application Launcher
APP_DIR="/home/gamp/Desktop/OpenSource/natively-cluely-ai-assistant"
cd "$APP_DIR"

# 1. Clean up zombie processes on the Vite port
fuser -k 5180/tcp > /dev/null 2>&1

# 2. Start Vite dev server in background
npm run dev -- --port 5180 --strictPort > /dev/null 2>&1 &

# 3. Wait for server readiness
until curl -s http://localhost:5180 > /dev/null; do
  sleep 0.5
done

# 4. Launch Electron with the essential Linux flags
npx cross-env NODE_ENV=development electron . --no-sandbox
