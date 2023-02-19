#!/bin/bash

set -xeuo pipefail

tee "${1?}" < /etc/redhat-release
