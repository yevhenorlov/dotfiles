#!/usr/bin/env bash

languages=$(echo "golang c cpp typescript rust\n" | tr " " "\n")
core_utils=$(echo "find xargs sed awk" | tr " " "\n")

echo "$languages $core_utils"
