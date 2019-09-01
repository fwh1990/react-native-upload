#!/usr/bin/env bash

set -e

dir=$(dirname $0)/$(dirname $(readlink $0))
libs=$dir/libs

EXPORT_METHOD=$(node $libs/get-config.js test_flight.ios_export_method)

sh $libs/appstore.sh $EXPORT_METHOD
