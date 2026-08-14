# Paperless AI Bundle

Home Assistant add-on repository. Thin wrappers around existing published
Docker images -- none of these rebuild the underlying apps, they just add a
small options.json -> env var bridge so each one gets a proper HA add-on
config screen, plus an optional built-in Tailscale sidecar.

**Does not touch your existing Paperless-ngx add-on.** These are separate
add-ons that talk to whatever Paperless instance you already have, over its
REST API. Point `paperless_url` / `paperless_base_url` at it and go.

## Add-ons

| Add-on | Wraps | Purpose |
|---|---|---|
| [Paperless-AI](./paperless-ai) | `clusterzx/paperless-ai` | AI tagging/title suggestions, RAG document chat |
| [Paperless-GPT](./paperless-gpt) | `icereed/paperless-gpt` | Vision-model OCR improvements |
| [Gotenberg](./gotenberg) | `gotenberg/gotenberg` | PDF/document conversion helper (internal API, no UI) |

## Install

Settings -> Add-ons -> Add-on Store -> ⋮ (top right) -> Repositories ->
add `https://github.com/dez011/paperless-ai-bundle`.

## Updates

Each Dockerfile pins `FROM <upstream>:latest`, so rebuilding an add-on
(Info tab -> Rebuild, or a version bump in this repo triggering an update)
re-pulls whatever upstream currently ships. This repo's own `version:`
fields need a bump for Supervisor to *notice* an update is available --
that's a manual step for now, not fully automatic yet.

## Ollama

None of these bundle their own Ollama. Point `ollama_api_url` /
`ollama_host` at whatever instance you're actually using (Home Assistant's
own, if you have one running, or a remote one over Tailscale/LAN).
`paperless-gpt`'s vision OCR needs a vision-capable model (e.g.
`minicpm-v:8b`) actually pulled on whichever Ollama it points at.
