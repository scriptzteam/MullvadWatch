curl -s "https://api.mullvad.net/www/relays/all/" | jq -r '
  .[] | [
    .hostname,
    .country_name,
    .city_name,
    .ipv4_addr_in,
    .ipv6_addr_in,
    (.active | tostring),
    .type,
    .fqdn,
    .provider,
    (.network_port_speed | tostring),
    (.multihop_port | tostring),
    .socks_name,
    (.socks_port | tostring),
    (.daita | tostring),
    .stboot,
    .owned,
    .pubkey
  ] | @tsv
' | awk -F'\t' '
  BEGIN {
    print "| Hostname    | Country   | City      | IPv4 Address    | IPv6 Address           | Active | Type     | FQDN                        | Provider | Port Speed | Multihop Port | SOCKS Name                  | SOCKS Port | Daita | Stboot | Owned | Pubkey                                                                                     |"
    print "|-------------|-----------|-----------|-----------------|------------------------|--------|----------|-----------------------------|----------|------------|---------------|-----------------------------|------------|-------|--------|-------|---------------------------------------------------------------------------------------------|"
  }
  {
    printf "| %-11s | %-9s | %-9s | %-15s | %-22s | %-6s | %-8s | %-27s | %-8s | %-10s | %-13s | %-25s | %-10s | %-5s | %-6s | %-5s | %-90s |\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17
  }
' > Readme.md
