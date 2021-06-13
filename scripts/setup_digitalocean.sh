#!/bin/sh
set -e

welcome() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi
    cat << EOF
-------------------------------------------------------------
|    Edgebox Cloud Image Builder: DigitalOcean - v0.0.1     |
-------------------------------------------------------------

Installing Edgebox Dependencies:
EOF
}

welcome
exit 0
