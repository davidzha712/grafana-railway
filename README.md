# Grafana on Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/5QsVtM)

Deploy **Grafana OSS** to [Railway](https://railway.app) with one click. PostgreSQL auto-provisioned — dashboards, data sources, and alerts persist across every redeploy.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/yzha)

## Features

| Feature | Description |
|---------|-------------|
| **Latest Grafana** | Always deploys the latest stable OSS version |
| **PostgreSQL Auto-Provisioned** | Database created automatically on deploy |
| **Zero Config** | `DATABASE_URL` wired automatically between services |
| **Health Check** | Built-in container and Railway health monitoring |
| **Plugin Support** | Install any Grafana plugin via environment variable |

## One-Click Deploy

Click the **Deploy on Railway** button above. Both Grafana and PostgreSQL will be created automatically — **zero configuration required**.

1. Wait 1–2 minutes for initialization
2. Open your Grafana service URL
3. Check **Deploy Logs** for your auto-generated admin password
4. Login with `admin` and the generated password

> **Tip**: Set `GF_SECURITY_ADMIN_PASSWORD` in Railway variables to use a fixed password across redeploys.

## Environment Variables

All variables are auto-configured. Override any of them in Railway service variables if needed.

| Variable | Default | Description |
|----------|---------|-------------|
| `DATABASE_URL` | Auto-wired | `${{Postgres.DATABASE_URL}}` |
| `PORT` | `3000` | Server port (auto-set by Railway) |
| `GF_SECURITY_ADMIN_USER` | `admin` | Admin username |
| `GF_SECURITY_ADMIN_PASSWORD` | Auto-generated | Secure random password (printed in deploy logs) |
| `GF_DEFAULT_INSTANCE_NAME` | Auto-detected | Uses `RAILWAY_PROJECT_NAME` or `grafana` |
| `GF_LOG_MODE` | `console` | Log output mode |
| `GF_INSTALL_PLUGINS` | — | Comma-separated plugin list (optional) |

## Installing Plugins

Set `GF_INSTALL_PLUGINS` in your Railway service variables:

```
grafana-clock-panel,grafana-simple-json-datasource
```

Browse the [Grafana Plugin Directory](https://grafana.com/grafana/plugins/) for available plugins.

## Local Development

```bash
cp .env.example .env
docker compose up -d
```

Open http://localhost:3000 and login with `admin` / `admin`.

## Resources

- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Railway Documentation](https://docs.railway.app/)
- [Grafana Plugin Directory](https://grafana.com/grafana/plugins/)

## License

[MIT](LICENSE)
