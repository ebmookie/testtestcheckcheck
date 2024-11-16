#!/bin/zsh

# Get a list of all network interfaces with IP addresses
# the () around the $() creates an array
# the awk2 gets the second field
#the sort-u gets unique entries
interfaces=($(ip -o -4 addr show | awk '{print $2}' | sort -u))

# Loop through each interface and extract its IP address
for iface in $interfaces; do
    # Get the IP address for the current interface
    ip=$(ip -o -4 addr show $iface | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+')
    
    if [ -n "$ip" ]; then
       
        # Dynamically create a variable with the format myIP_<interface>
        eval "myIP_$iface='$ip'"
    else
        echo "No IP address found for $iface"
    fi

done

# Display the variables to confirm they're set
echo "Captured IP addresses:"
for iface in $interfaces; do
    eval "echo myIP_$iface: \$myIP_$iface"
done

