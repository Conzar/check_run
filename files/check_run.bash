#!/bin/bash
#
# Checks if a file exists.
#
test -e $1
if [ $? -eq 1 ]; then 
	exit 0;
fi
exit 1;