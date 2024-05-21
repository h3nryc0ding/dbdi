#!/bin/bash

set -e
if [ "$1" = "" ]; then
  echo "No scale factor provided.  Using scale factor 1."
  echo "To use another scale factor use $0 X where X is an integer value between 1 and 1000"
  SIZE=1
else
  SIZE=$1
fi;
echo "Generating new data set of scale factor $SIZE"  
ssb-dbgen/dbgen -s $SIZE -T l > /dev/null 2>&1 &
ssb-dbgen/dbgen -s $SIZE -T c > /dev/null 2>&1 &
ssb-dbgen/dbgen -s $SIZE -T d > /dev/null 2>&1 &
ssb-dbgen/dbgen -s $SIZE -T p > /dev/null 2>&1 &
ssb-dbgen/dbgen -s $SIZE -T s > /dev/null 2>&1 &
wait
echo "Data generation completed!"
du -sh *.tbl