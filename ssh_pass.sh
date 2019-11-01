#!/bin/bash

set -euo pipefail
IFS=$' \n\t'

OLDDIR=$(pwd)
SRCPATH=$(readlink -f "${0}")
WORKDIR=$(dirname "${SRCPATH}")
cd "${WORKDIR}"

script_name="${0:-UNDEFINED}"
comm="${1:-UNDEFINED}"
ssh_pass="${2:-UNDEFINED}"
exported_ssh_pass="${SSH_PASS:-UNDEFINED}"
exported_display="${DISPLAY:-UNDEFINED}"

if [ "${exported_ssh_pass}" != 'UNDEFINED' ]
then 
    echo "${exported_ssh_pass}"
    exit 0
fi

export SSH_ASKPASS="${script_name}"
export SSH_PASS="${ssh_pass}"
 
[ "${exported_display}" != 'UNDEFINED' ] || export DISPLAY=":0"

setsid ${comm}
