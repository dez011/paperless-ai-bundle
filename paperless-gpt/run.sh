#!/bin/sh
# Reads HA add-on options (written to /data/options.json by Supervisor) and
# exports them as the plain env vars the upstream image already expects.
set -e

OPTS=/data/options.json

export PAPERLESS_BASE_URL="$(jq -r '.paperless_base_url' "$OPTS")"
export PAPERLESS_API_TOKEN="$(jq -r '.paperless_api_token' "$OPTS")"

export LLM_PROVIDER=ollama
export LLM_MODEL="$(jq -r '.llm_model' "$OPTS")"
export OLLAMA_HOST="$(jq -r '.ollama_host' "$OPTS")"
export OLLAMA_CONTEXT_LENGTH="$(jq -r '.ollama_context_length // 8192' "$OPTS")"
export TOKEN_LIMIT="$(jq -r '.token_limit // 1000' "$OPTS")"
export LLM_LANGUAGE="$(jq -r '.llm_language // "English"' "$OPTS")"

export OCR_PROVIDER=llm
export VISION_LLM_PROVIDER=ollama
export VISION_LLM_MODEL="$(jq -r '.vision_llm_model' "$OPTS")"

export AUTO_OCR_TAG=paperless-gpt-ocr-auto
export AUTO_TAG=paperless-gpt-auto
export MANUAL_TAG=paperless-gpt-manual
export PDF_OCR_TAGGING=true
export PDF_OCR_COMPLETE_TAG=paperless-gpt-ocr-complete
export PDF_UPLOAD=false
export LOG_LEVEL="$(jq -r '.log_level // "INFO"' "$OPTS")"

TAILSCALE_ENABLED="$(jq -r '.tailscale_enabled // false' "$OPTS")"
if [ "$TAILSCALE_ENABLED" = "true" ]; then
  TAILSCALE_AUTHKEY="$(jq -r '.tailscale_authkey // empty' "$OPTS")"
  mkdir -p /data/tailscale
  tailscaled --state=/data/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
  sleep 2
  if [ -n "$TAILSCALE_AUTHKEY" ]; then
    tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname=paperless-gpt --accept-dns=true || \
      echo "[paperless-gpt] tailscale up failed -- check the authkey option"
  else
    echo "[paperless-gpt] tailscale_enabled is true but no authkey set; tailscaled is running, run 'tailscale up' manually via the add-on's terminal"
  fi
fi

exec ./entrypoint.sh
