# Thin HA add-on wrapper around the upstream image -- not a rebuild of the
# app itself (base is Alpine). Pinning :latest means every rebuild of this
# add-on re-pulls whatever upstream currently publishes as :latest.
FROM icereed/paperless-gpt:latest

RUN apk add --no-cache jq tailscale

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
