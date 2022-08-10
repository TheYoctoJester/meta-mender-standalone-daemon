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
if systemctl --quiet is-active mender-bist-commit.service > /dev/null 2>&1; then
  fatal "mender-bist-commit.service is still active. Wait longer before you can update again."
fi

exit