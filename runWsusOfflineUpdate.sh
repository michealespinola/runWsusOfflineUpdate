#!/bin/bash
#
# A script to selectively start and stop the wsusoffline script on Synology NAS
# This must be run as root to natively control running services
#
# Author @michealespinola https://github.com/michealespinola/runWsusOfflineUpdate
#
# Example Synology DSM Scheduled Task type 'user-defined script': 
# bash /volume1/homes/admin/scripts/bash/docker/runWsusOfflineUpdate.sh

# START WSUSOFFLINE CONTAINER
docker start wsusoffline
echo 

# CHECK IF WSUSOFFLINE CONTAINER IS RUNNING
if docker ps | grep -q "wsusoffline"; then
  # WHILE RUNNING KEEP MONITORING FOR THE FINAL SCRIPT SLEEP COMMAND OF "SLEEP 48H"
  while [[ $(docker top wsusoffline | grep -o "sleep 48h") != "sleep 48h" ]]; do
    printf '\r\e[K%s' "Waiting to finish (5s loop).."
    sleep 5
    printf '\r\e[K'
  done
  printf '\r\e[K%s\n' "Finished.."
  # STOP THE WSUSOFFLINE CONTAINER WHEN THE SCRIPT IS FINISHED AND IS SLEEPING
  #docker kill --signal=SIGINT wsusoffline
  docker stop -t 900 wsusoffline
else
  # IF CONTAINER NOT RUNNING PRINT THIS MESSAGE
  printf '%s\n' "wsusoffline container is not running.."
fi

# UNCOMMENT TO FORCE KILL IF YOU REALLY THINK ITS NECCESSARY
# if [ ! "$(docker ps -q -f name=wsusoffline)" ]; then
#     if [ "$(docker ps -aq -f status=exited -f name=wsusoffline)" ]; then
#         exit
#     fi
#     docker kill wsusoffline
# fi
