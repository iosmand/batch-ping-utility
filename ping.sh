#!/bin/bash
FILES=$(cat $1)
if [ -z "$1" ]; then
  echo "First parameter not supplied."
	exit 1
fi

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