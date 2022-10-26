#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ls -1 > $SCRIPT_DIR/filenames.txt
sed -i 's/.v/.v \\/g' $SCRIPT_DIR/filenames.txt
