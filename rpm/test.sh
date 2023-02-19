#!/bin/bash

set -xeuo pipefail

[[ "$(rpm --query --queryformat "${2?}" --package "${3?}")" =~ ${1?} ]]
