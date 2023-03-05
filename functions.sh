#!/usr/bin/env bash

function log_string() {
    echo "$1"
}

function parse_env_file() {
    if [ -f "$1" ]; then
        # shellcheck disable=SC2046
        export $(grep -v '^#' "$1" | xargs)
    else
        log_string "No $1 file found"
        exit 1
    fi
}