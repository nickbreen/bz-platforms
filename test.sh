#!/bin/bash

set -xeuo pipefail

bazel test //... --config docker --config debian "$@"
bazel test //... --config docker --config fedora "$@"
bazel test //... --config docker --config ubuntu "$@"
bazel test //... --config docker --config rocky "$@"
bazel test //... --config docker --config centos "$@"

