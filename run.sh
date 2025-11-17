#!/usr/bin/env bash
set -euo pipefail

# Change to workspace root (script location)
cd "$(dirname "$0")"

# Ensure dotnet is available
if ! command -v dotnet >/dev/null 2>&1; then
    echo "Error: dotnet CLI not found in PATH. Install the .NET SDK or use a dev container with dotnet."
    exit 1
fi

# Listen on all interfaces so container port forwarding works
export ASPNETCORE_URLS="http://0.0.0.0:5000;https://0.0.0.0:5001"

echo "Starting ASP.NET Core application (dotnet watch run)..."
# Open browser shortly after starting the server (if $BROWSER is set)
(
  sleep 2
  if [ -n "${BROWSER-}" ]; then
    "$BROWSER" "http://localhost:5000" >/dev/null 2>&1 &
  else
    echo "Tip: set \$BROWSER to automatically open the app: export BROWSER=\"<your-browser-command>\""
    echo "Open manually: http://localhost:5000"
  fi
) &

# Run the app with file-watch to pick up code changes
dotnet watch run
