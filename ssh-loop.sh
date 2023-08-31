#!/bin/bash
#Script for connecting via ssh to a list of hosts and executing a command.
#Credentials must be entered manually per connection - this can be modified to support keys.
#Create a file called hostlist.txt and include one host per line.

hosts=($( cat hostlist.txt ))

echo ${hosts[@]}
for host in ${hosts[@]}; do
ssh -t -o "StrictHostKeyChecking no" systems"@"$host "sudo dsconfigad -show && sudo dsconfigad -packetsign require && sudo dsconfigad -packetencrypt ssl && sudo dsconfigad -show"
done
