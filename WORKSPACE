# //:toolchain/* are (now) constrained by //dist:* so we can register all of them
# Note that these need to be constrained, not //lsb/toolchains:*
register_toolchains(
    "//:toolchain/debian",
    "//:toolchain/fedora",
    "//:toolchain/ubuntu",
    "//:toolchain/centos",
    "//:toolchain/rocky",
)

# //:platform/* are constrained by //dist:* so we can register all of them
register_execution_platforms(
    "//:platform/linux/debian",
    "//:platform/linux/fedora",
    "//:platform/linux/ubuntu",
    "//:platform/linux/centos",
    "//:platform/linux/rocky",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "b8a1527901774180afc798aeb28c4634bdccf19c4d98e7bdd1ce79d1fe9aaad7",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
    ],
)

http_archive(
    name = "rules_python",
    sha256 = "29a801171f7ca190c543406f9894abf2d483c206e14d6acbd695623662320097",
    strip_prefix = "rules_python-0.18.1",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.18.1/rules_python-0.18.1.tar.gz",
)

register_toolchains("//:toolchain/python")

#load("@rules_python//python:repositories.bzl", "python_register_toolchains")
#
#python_register_toolchains(
#    name = "python3.",
#    # Available versions are listed in @rules_python//python:versions.bzl.
#    # We recommend using the same version your team is already standardized on.
#    python_version = "3.9",
#)
#
#python_register_toolchains(
#    name = "python3_9",
#    # Available versions are listed in @rules_python//python:versions.bzl.
#    # We recommend using the same version your team is already standardized on.
#    python_version = "3.9",
#)

http_archive(
    name = "rules_pkg",
    sha256 = "8c20f74bca25d2d442b327ae26768c02cf3c99e93fad0381f32be9aab1967675",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.8.1/rules_pkg-0.8.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.8.1/rules_pkg-0.8.1.tar.gz",
    ],
)

register_toolchains("//:toolchain/rocky/rpmbuild", "//:toolchain/centos/rpmbuild")
