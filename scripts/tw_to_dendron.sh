#!/bin/sh
task status:completed end:today export | jq '.[].description' --raw-output

