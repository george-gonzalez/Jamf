#!/bin/bash

# Script to remove SSID from the list of preferred networks

SSID=""
NetworkPort=$(/usr/sbin/networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device| cut -d ' ' -f2)
net=$(networksetup -listpreferredwirelessnetworks $NetworkPort | grep ${SSID} | cut -f2)
ap=$(networksetup -getairportnetwork $NetworkPort | cut -d ":" -f 2 | cut -c 2-)

# Show which interface is using Wifi
echo $NetworkPort

# Remove Network if exists in saved networks
if [ "$net" = "$SSID" ]
  then networksetup -removepreferredwirelessnetwork $NetworkPort ${SSID}
  sleep 5

else echo "No Network"
fi

#Powercycle wireless adapter if connected to banned network

if [ "$ap" = "$SSID" ]
  then  networksetup -setairportpower $NetworkPort off
                sleep 2
        networksetup -setairportpower $NetworkPort on
fi

#
#TITLE="Access Denied"
#MSG="Please do not connect to unauthorized Wireless network."
#
#/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "$TITLE" -description "$MSG" -button1 "Close" -lockHUD -icon /Library/LC/Logo.icns
