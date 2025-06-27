% cat vpncheck.sh
#!/bin/bash

# Define the list of domains
domains=(
  "vpn.dal.softlayer.com"
  "vpn.mon01.softlayer.com"
  "vpn.sjc.softlayer.com"
  "vpn.tor.softlayer.com"
  "vpn.wdc.softlayer.com"
  "vpn.sao.softlayer.com"
  "vpn.ams03.softlayer.com"
  "vpn.fra.softlayer.com"
  "vpn.lon.softlayer.com"
  "vpn.mil01.softlayer.com"
  "vpn.par.softlayer.com"
  "vpn.par01.softlayer.com"
  "vpn.che01.softlayer.com"
  "vpn.osa.softlayer.com"
  "vpn.sng01.softlayer.com"
  "vpn.syd.softlayer.com"
  "vpn.tok.softlayer.com"
)

# Print the header
echo -e "Domain\t\t\tAvg RTT (ms)"
echo "-------------------------------------"

# Check the operating system
os=$(uname)

# Loop through the domain list
for domain in "${domains[@]}"
do
  # Use ping to test for 5 seconds and extract avg RTT value
  if [ "$os" = "Darwin" ]; then
    # macOS
    avg=$(ping -c 5 "$domain" | awk -F '=' '/round-trip/ {split($2,a,"/"); print a[2]}')
  else
    # Assume Linux
    avg=$(ping -c 5 "$domain" | awk -F '/' '/rtt/ {print $5}')
  fi

  # Check if a result was obtained
  if [ -n "$avg" ]; then
    echo -e "$domain\t$avg ms"
  else
    echo -e "$domain\tPing failed"
  fi
done
