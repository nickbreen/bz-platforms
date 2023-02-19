#!/bin/bash

set -xeuo pipefail

. /etc/os-release
echo "${!1?}" | tee "${2?}"
