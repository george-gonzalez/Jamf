#!/bin/sh

# script to remove administrative privileges from macOS devices. 

adminUsers=$(dscl . -read Groups/admin GroupMembership | cut -c 18-)

for user in $adminUsers
do
    if [ "$user" != "root" ] && [ "$user" != "jamf_ladmin" ] && [ "$user" != "systems" ] && [ "$user" != "casperscreensharing" ] && [ "$user" != "svc_quickadd" ]
    then 
        dseditgroup -o edit -d $user -t user admin
        if [ $? = 0 ]; then echo "Removed user $user from admin group"; fi
    else
        echo "Admin user $user left alone"
    fi
done
