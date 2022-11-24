#!/bin/sh

#Script to check for installed machine certificate and report the Expiry date.
#Edited by George Gonzalez
#Output result for use as Extension Attribute
#2022.11.23.1

#Get local user information - not currently used but just in case

username=( stat -f%Su /dev/console )

if [ $username = "root" ]; then

    exit

else

#Get the local machine host name

machine_name=$( /usr/sbin/scutil --get ComputerName)

if [ $machine_name = "" ]; then

    exit

else

#Select the Systems Keychain

desired_keychain="/Library/Keychains/System.keychain"

#Find a certificate with the machine name and check the expiration date

certexpdate=$( /usr/bin/security find-certificate -a -c "$machine_name" -p -Z "$desired_keychain" | /usr/bin/openssl x509 -noout -enddate | cut -f2 -d= )

#Convert the expiration date from GMT to EST

dateformat=$(/bin/date -j -f "%b %d %T %Y %Z" "$certexpdate" "%m-%d-%Y %H:%M:%S")

#Output the results to a JAMF-friendly Attribute.

echo "<result>$dateformat</result>"

fi

fi
