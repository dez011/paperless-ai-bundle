# Thin HA add-on wrapper around the upstream image -- not a rebuild of the
# app itself (base is Debian bookworm). Pinning :latest means every rebuild
# of this add-on (manual "Rebuild" in the HA UI, or a version bump in this
# repo) re-pulls whatever upstream currently publishes as :latest.
FROM clusterzx/paperless-ai:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq ca-certificates curl gnupg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg -o /usr/share/keyrings/tailscale-archive-keyring.gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list -o /etc/apt/sources.list.d/tailscale.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends tailscale && \
    rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
