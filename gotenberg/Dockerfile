# Thin HA add-on wrapper around the upstream image (base is Debian trixie).
# Internal document-conversion helper -- no web UI, just an API other
# services on the same network call. Pinning :latest means every rebuild of
# this add-on re-pulls whatever upstream currently publishes as :latest.
FROM gotenberg/gotenberg:8.25

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq && \
    rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
