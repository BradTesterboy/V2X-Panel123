#!/bin/bash
set -e

export HOME=/home/sulgx

if [ -d /data ]; then
    chown -R sulgx:sulgx /data 2>/dev/null || true
fi

# ---------- Cloudflare WARP Hybrid Engine ----------
WARP_STATE_FILE="/data/warp_state.json"
WARP_DATA_DIR="/data/cloudflare-warp"

if [ -f "$WARP_STATE_FILE" ] && command -v jq &> /dev/null; then
    WARP_ENABLED=$(jq -r '.enabled // false' "$WARP_STATE_FILE")
else
    WARP_ENABLED="false"
fi

if [ "$WARP_ENABLED" = "true" ]; then
    echo ">>> Initializing Cloudflare WARP..."

    mkdir -p "$WARP_DATA_DIR"

    if [ -e /dev/net/tun ]; then
        echo ">>> TUN device detected. Operating in Global VPN (TUN) Mode."
        WARP_MODE="warp"
    else
        echo ">>> WARNING: /dev/net/tun NOT detected."
        echo ">>> Bypassing VPN mode. Falling back to SOCKS5 Proxy Mode (Port 40000)."
        WARP_MODE="proxy"
        export WARP_PROXY_ACTIVE="true"
        export WARP_PROXY_PORT="40000"
    fi

    if [ -f "$WARP_DATA_DIR/conf.json" ]; then
        echo ">>> Restoring persisted WARP identity..."
        mkdir -p /var/lib/cloudflare-warp
        cp -r "$WARP_DATA_DIR"/* /var/lib/cloudflare-warp/ 2>/dev/null || true
    fi

    echo ">>> Launching warp-svc daemon..."
    warp-svc > /dev/null 2>&1 &
    sleep 4

    if ! warp-cli --accept-tos account 2>/dev/null | grep -q "Account type"; then
        echo ">>> Registering new WARP client..."
        warp-cli --accept-tos register
        cp -r /var/lib/cloudflare-warp/* "$WARP_DATA_DIR/" 2>/dev/null || true
        chown -R sulgx:sulgx "$WARP_DATA_DIR" 2>/dev/null || true
    fi

    warp-cli --accept-tos set-mode "$WARP_MODE"
    if [ "$WARP_MODE" = "proxy" ]; then
        warp-cli --accept-tos set-proxy-port 40000
    fi

    warp-cli --accept-tos connect
    sleep 6

    if [ "$WARP_MODE" = "warp" ]; then
        echo ">>> WARP active (TUN). Egress IP: $(curl -s --max-time 4 ifconfig.me || echo 'Unknown')"
    else
        echo ">>> WARP active (SOCKS5). Egress IP via Proxy: $(curl -s --socks5-hostname 127.0.0.1:40000 --max-time 4 ifconfig.me || echo 'Unknown')"
    fi

    if [ -d /data ]; then
        chown -R sulgx:sulgx /data 2>/dev/null || true
    fi
else
    echo ">>> WARP is disabled via Settings. Skipping initialization."
fi
# --------------------------------------------------

exec gosu sulgx python main.py
