#!/bin/bash

set -xeuo pipefail

bazel build //rpm/... --config docker --config centos "$@"
bazel build //rpm/... --config docker --config rocky "$@"

bazel test //... --config docker --config debian "$@"
bazel test //... --config docker --config fedora "$@"
bazel test //... --config docker --config ubuntu "$@"
bazel test //... --config docker --config rocky "$@"
bazel test //... --config docker --config centos "$@"

