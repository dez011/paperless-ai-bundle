# Thin HA add-on wrapper around the upstream image -- not a rebuild of the
# app itself (base is Debian bookworm). Pinning :latest means every rebuild
# of this add-on (manual "Rebuild" in the HA UI, or a version bump in this
# repo) re-pulls whatever upstream currently publishes as :latest.
FROM clusterzx/paperless-ai:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq tailscale ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
