#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./ping.sh INPUT_FILE PING_COUNT"
  echo "In the INPUT_FILE IP Addresses should list with spaces NOT ROWS. (8.8.8.8 8.8.4.4 1.1.1.1)"
	echo "PING_COUNT is number of packets per IP Address. default=10"
  exit 1
fi

iplist=$(cat $1)

if [ -z ${2+x} ]; then times=10; else times=$2; fi

echo -e 'IP Address\tPING' >> result_$1
echo -e 'IP Address\t\tPING'

for f in $FILES
do
  preping=$(ping -c 2 $f)
  ping=$(ping -c $times $f | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  echo -e $f'\t'$ping >> result_$1
  echo -e $f'\t\t'$ping
done