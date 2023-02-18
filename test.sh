#!/bin/bash

set -xeuo pipefail

bazel clean
bazel test //... --config docker --config debian
bazel test //... --config docker --config fedora
bazel test //... --config docker --config ubuntu

