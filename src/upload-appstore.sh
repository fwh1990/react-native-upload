#!/usr/bin/env bash

set -e

dir=$(dirname $0)/$(dirname $(readlink $0))
libs=$dir/libs

sh $libs/appstore.sh app-store
