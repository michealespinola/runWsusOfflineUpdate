![GitHub top language](https://img.shields.io/github/languages/top/michealespinola/runWsusOfflineUpdate
)
![GitHub](https://img.shields.io/github/license/michealespinola/runWsusOfflineUpdate)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2RYY4BETEQAJC)

# runWsusOfflineUpdate

This is a bash script to selectively start and stop the wsusoffline script on Synology NAS. This allows you to more granularly control when it runs; such as manually, a scheduled system task, or executed by other mechanisms.

This script does the following:

1. Check if the wsusoffline docker container is running
1. If not, start the container
1. Check its status every 15 seconds to see if its completed its cycle and paused at its default 48h sleep mode setting
1. If it is sleeping for 48h, stop the container

I wrote this script because there is no reason to have this container running and looping a script every 48h when Windows Updates are typically released the second Tuesday of the month (aka "Patch Tuesday").

> *Microsoft schedules the release of security updates on "Patch Tuesday," the second Tuesday of each month at 10:00 AM PST.*
>
> *Depending on time zone(s) in which the organization operates, IT pros should plan their deployment schedules accordingly. Please note that there are some products that do not follow the Patch Tuesday schedule.*
