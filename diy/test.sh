#!/bin/bash

set -xeuo pipefail

[[ "$(<${1?})" =~ ${2?} ]]
