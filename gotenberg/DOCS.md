# Gotenberg

Wraps [gotenberg/gotenberg](https://github.com/gotenberg/gotenberg). Pure
document/PDF conversion API -- no web UI, nothing to log into. Other
services (Paperless itself, or a self-hosted Paperless-ngx instance) point
at it internally for converting non-PDF documents during ingest.

Not wired into your existing Paperless-ngx add-on automatically -- that add-on
likely already bundles its own Gotenberg internally. This one exists as a
standalone, reusable instance if you ever need one outside that bundle.
