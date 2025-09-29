proxied=$( curl -s -x localhost:8118 ifconfig.me )
non_proxied=$( curl -s -4 ifconfig.me )

if [[ $proxied = $non_proxied ]]; then exit 1; else exit 0; fi
