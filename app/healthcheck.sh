#!/bin/sh
# Healthy only if the tunnel is up and the proxy actually gets traffic out. Inside this container
# "direct" traffic also rides the tunnel (OpenVPN owns the default route), so comparing proxied vs
# direct IPs proves nothing; and an empty proxied IP (tunnel down, Privoxy answering 500) used to pass
# as healthy because it "differed".
if ! ip route | grep -q ' dev tun0'; then
  echo "unhealthy: no routes via tun0 (tunnel down)"; exit 1
fi
proxied=$( curl -s -m 20 -x localhost:8118 https://api.ipify.org )
case "$proxied" in
  ''|*[!0-9.]*) echo "unhealthy: no exit IP through the proxy (got '$proxied')"; exit 1 ;;
esac
echo "healthy: exit $proxied"
exit 0
