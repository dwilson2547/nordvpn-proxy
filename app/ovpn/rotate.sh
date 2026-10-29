#!/bin/bash
# Move to a different exit server. Stopping openvpn makes runit rerun /app/ovpn/run, which picks a fresh
# server from the recommendations (servers_recommendations.sh skips the one we're leaving). Without this
# the exit only changed when the tunnel died: one IP carried every scraper for days until Cloudflare
# banned it (2026-10-29).

. /app/date.sh --source-only

echo "$(adddate) INFO: Rotating exit server (leaving $(cat /tmp/nordvpn_hostname 2>/dev/null))"
pgrep openvpn | xargs -r kill -15
