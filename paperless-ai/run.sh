#!/bin/sh
# Reads HA add-on options (written to /data/options.json by Supervisor) and
# exports them as the plain env vars the upstream image already expects --
# the app itself has no idea it's running inside a HA add-on.
set -e

OPTS=/data/options.json

export PAPERLESS_URL="$(jq -r '.paperless_url' "$OPTS")"
export PAPERLESS_API_URL="${PAPERLESS_URL}/api"
export PAPERLESS_API_TOKEN="$(jq -r '.paperless_api_token' "$OPTS")"
export PAPERLESS_USERNAME="$(jq -r '.paperless_username' "$OPTS")"
export AI_PROVIDER=ollama
export OLLAMA_API_URL="$(jq -r '.ollama_api_url' "$OPTS")"
export OLLAMA_MODEL="$(jq -r '.ollama_model' "$OPTS")"
export SCAN_INTERVAL="$(jq -r '.scan_interval' "$OPTS")"
export TZ="$(jq -r '.timezone // "UTC"' "$OPTS")"

TAILSCALE_ENABLED="$(jq -r '.tailscale_enabled // false' "$OPTS")"
if [ "$TAILSCALE_ENABLED" = "true" ]; then
  TAILSCALE_AUTHKEY="$(jq -r '.tailscale_authkey // empty' "$OPTS")"
  mkdir -p /data/tailscale
  tailscaled --state=/data/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
  sleep 2
  if [ -n "$TAILSCALE_AUTHKEY" ]; then
    tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname=paperless-ai --accept-dns=true || \
      echo "[paperless-ai] tailscale up failed -- check the authkey option"
  else
    echo "[paperless-ai] tailscale_enabled is true but no authkey set; tailscaled is running, run 'tailscale up' manually via the add-on's terminal"
  fi
fi

# Hand off to the app's own real entrypoint -- we're not replacing its
# startup logic, just making sure the right env vars exist before it runs.
exec docker-entrypoint.sh ./start-services.sh
