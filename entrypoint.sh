#!/bin/sh
set -e

# Bridge Railway PORT to Grafana
export GF_SERVER_HTTP_PORT="${PORT:-3000}"

# Auto-generate admin password if not explicitly set
if [ -z "$GF_SECURITY_ADMIN_PASSWORD" ]; then
    GF_SECURITY_ADMIN_PASSWORD=$(head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 24)
    export GF_SECURITY_ADMIN_PASSWORD
    echo "============================================"
    echo "  Grafana Admin Credentials (auto-generated)"
    echo "  User:     ${GF_SECURITY_ADMIN_USER:-admin}"
    echo "  Password: ${GF_SECURITY_ADMIN_PASSWORD}"
    echo "  "
    echo "  Save this password! Set GF_SECURITY_ADMIN_PASSWORD"
    echo "  to use a fixed password across redeploys."
    echo "============================================"
fi

# Default instance name from Railway project or fallback
if [ -z "$GF_DEFAULT_INSTANCE_NAME" ]; then
    export GF_DEFAULT_INSTANCE_NAME="${RAILWAY_PROJECT_NAME:-grafana}"
fi

# Parse DATABASE_URL into individual Grafana database env vars
# Handles both postgres:// and postgresql:// schemes
# Grafana requires type "postgres" (not "postgresql")
if [ -n "$DATABASE_URL" ]; then
    export GF_DATABASE_TYPE="postgres"

    # Strip scheme (postgres:// or postgresql://)
    url_without_scheme="${DATABASE_URL#*://}"

    # Extract user info (everything before @)
    userinfo="${url_without_scheme%%@*}"
    export GF_DATABASE_USER="${userinfo%%:*}"
    export GF_DATABASE_PASSWORD="${userinfo#*:}"

    # Extract host+port and dbname (everything after @)
    hostport_db="${url_without_scheme#*@}"
    export GF_DATABASE_HOST="${hostport_db%%/*}"
    export GF_DATABASE_NAME="${hostport_db#*/}"
fi

exec /run.sh "$@"
