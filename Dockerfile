FROM grafana/grafana-oss:latest

USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER grafana

ENV GF_LOG_MODE=console \
    GF_SECURITY_ADMIN_USER=admin

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-3000}/api/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]
