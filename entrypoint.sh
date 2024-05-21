#!/bin/bash

# start postgresql service
service postgresql start

# check if any arguments were passed
if [ $# -eq 0 ]; then 
    # no arguments were passed, start an interactive shell
    bash 
else 
    # arguments were passed, check if it's a file or a string
    if [ -f "$1" ]; then 
        # it's a file, execute it with psql -f
        psql -U root -d ssb -f "$1" 
    else 
        # it's a string, execute it with psql -c
        psql -U root -d ssb -c "$1" 
    fi 
fi

# stop postgresql service
service postgresql stop