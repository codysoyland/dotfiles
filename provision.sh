#!/usr/bin/env bash
# Split off from provision.sh which is pure borne shell as FreeBSD does not
# come with bash. Everything from here on is bash.

# exit on error
set -Eeo pipefail

if [ ! "$PLATFORM" ]; then
    # shellcheck disable=SC2016
    echo '$PLATFORM required'
    exit 1
fi

# contains utilities for downloading and installation
source system-dependencies/include/util.sh

# adhoc program installers
source system-dependencies/include/adhoc.sh

# system-dependencies (run by root)
# shellcheck disable=SC1090
source system-dependencies/"${PLATFORM}".sh

# system-configuration (run by root)
# shellcheck disable=SC1090
source system-configuration/"${PLATFORM}".sh

# user-configuration (run by current user)
if [[ $(whoami) == naggie ]]; then
    ./user-configuration-naggie.sh
else
    ./user-configuration.sh
fi

printf '\n\e[1;32m%s\e[m\n' "PROVISIONING SUCCESSFUL"
