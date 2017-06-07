#!/bin/bash
# Author: Ian Leeder
# Date: 20 June 2016
# Version 1.0 - Initial release
# 1.1 - Redirect error output to null.  Check if valid response before logging.

# This is a script to automate testing of my internet bandwidth via a CLI interface
# to the Speedtest.Net site.  CLI wrapper for Speedtest site comes from here:
# https://github.com/sivel/speedtest-cli

# Also logs the output to a logfile in a nice usable format
# that can be easily graphed.

# These are the Melbourne-based servers, I have explicitly selected to test
# against Telstra (2225) every time to aid in consistency.
# 2225) Telstra (Melbourne, Australia) [15.14 km]
# 5977) SoftLayer Technologies, Inc. (Melbourne, Australia) [15.14 km]
# 6141) AARNet (Melbourne, Australia) [15.14 km]
# 2169) Internode (Melbourne, Australia) [15.14 km]
# 1564) 'Yes' Optus (Melbourne, Australia) [15.14 km]

# These can be listed with
# speedtest-cli --list

# Change to script directory, as per
# http://stackoverflow.com/a/246128
# But as per http://stackoverflow.com/a/6659698 no solution works in all cases
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

dateTime=$(date '+%Y%m%d %H:%M:%S');
fullResults=$(./speedtest-cli --simple --server 2225 2>/dev/null);
#fullResults=$(cat testoutput);
resultsArray=($fullResults)
pingResult=${resultsArray[1]}
downResult=${resultsArray[4]}
upResult=${resultsArray[7]}

# Check if the full results array contained the expected number of elements
# http://unix.stackexchange.com/a/193042
if [ ${#resultsArray[@]} = 9 ]; then
    echo -e "$dateTime\t$pingResult\t$downResult\t$upResult" >> results.log
else
    echo -e "$dateTime\terror\terror\terror" >> results.log
fi
