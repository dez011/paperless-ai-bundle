#!/bin/sh
# Gotenberg has no env-based config -- everything is CLI flags. Reads HA
# options and builds the flag list, then hands off to the real binary.
set -e

OPTS=/data/options.json

DISABLE_JS="$(jq -r '.chromium_disable_javascript // true' "$OPTS")"

exec /usr/bin/tini -- gotenberg \
  --chromium-disable-javascript="${DISABLE_JS}" \
  --chromium-allow-list="file:///tmp/.*"
