#!/bin/sh
set -e

function log {
  echo "$@" >&2
}
log "$(cat /etc/mender/artifact_info): $(basename "$0") was called!"

function fatal {
  log $@
  exit 1
}

################################################################################
if   systemctl is-system-running | grep -q "initializing\|starting"   > /dev/null 2>&1; then
  fatal "system has not finish start-up process. Wait longer before you can update."
elif systemctl --quiet is-active mender-bist-commit.service > /dev/null 2>&1; then
  fatal "mender-bist-commit.service is still active. Wait longer before you can update."
elif systemctl --quiet is-failed mender-bist-commit.service > /dev/null 2>&1; then
  fatal "mender-bist-commit.service is in a failed state. A reboot is required to rollback this failed update."
fi

exit
