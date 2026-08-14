# Paperless-GPT

Wraps [icereed/paperless-gpt](https://github.com/icereed/paperless-gpt).
Vision-model OCR improvements and metadata suggestions for an existing
Paperless-ngx instance.

## Options

- `paperless_base_url` / `paperless_api_token` -- same as Paperless-AI,
  point at your existing Paperless instance.
- `llm_model` -- text model for metadata reasoning.
- `ollama_host` -- any reachable Ollama instance (not bundled here).
- `vision_llm_model` -- must be a vision-capable model (e.g. `minicpm-v:8b`,
  `qwen3-vl:8b`) actually pulled on that Ollama, or OCR will fail.
- `tailscale_enabled` / `tailscale_authkey` -- optional, same as
  Paperless-AI.

## Note

`PDF_UPLOAD` is left off by default (matches the archived stack this was
built from) -- it only processes documents already in Paperless, doesn't
accept direct uploads through its own UI.
