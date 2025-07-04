#!/bin/bash

curr_dir=$(pwd)
if [ "$curr_dir" != "/opt" ]; then
    cd /opt
fi

code_dir=$1
cd $code_dir

if [ $? -ne 0 ]; then
    exit 1
fi


go mod tidy
go test -gcflags "all=-N -l" -coverprofile=coverage.out ./...

COVERAGE=$(go tool cover -func=coverage.out | grep total | awk '{print $3}' | sed 's/%//')

echo "Coverage: $COVERAGE%"

DT_COVER_THRESHOLD=$2

if awk "BEGIN { exit !($COVERAGE < $DT_COVER_THRESHOLD) }"; then
    echo "Coverage is $COVERAGE% less than Threshold($DT_COVER_THRESHOLD)"
    exit 1
else
    echo "Coverage is $COVERAGE% equal or more than Threshold($DT_COVER_THRESHOLD)"
fi