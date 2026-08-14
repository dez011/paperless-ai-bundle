# Paperless-AI

Wraps [clusterzx/paperless-ai](https://github.com/clusterzx/paperless-ai).
Scans your existing Paperless-ngx instance on a schedule and suggests
tags/titles/correspondents via an Ollama model, plus a RAG chat over your
documents.

## Options

- `paperless_url` -- base URL of your Paperless instance (e.g.
  `http://100.101.81.127:8000` if it's the same box this add-on runs on,
  use its internal address instead).
- `paperless_api_token` -- generate one in Paperless: profile -> API Tokens.
- `paperless_username` -- your actual Paperless login username (must match
  exactly, or Paperless-AI can't resolve your account for RAG features).
- `ollama_api_url` -- any reachable Ollama instance. This add-on does not
  bundle its own.
- `ollama_model` -- a text model already pulled on that Ollama.
- `scan_interval` -- cron expression, default every 30 minutes.
- `tailscale_enabled` / `tailscale_authkey` -- optional. Gives this add-on
  its own Tailscale identity independent of Ingress. Generate an auth key
  from the Tailscale admin console.

## First run

This app has its own one-time setup wizard separate from the options above
-- open the add-on's Web UI (or Ingress panel) and complete it once. The
options here get read as env vars on every start; the wizard's own account
creation is a one-time thing stored in the add-on's persistent data.
