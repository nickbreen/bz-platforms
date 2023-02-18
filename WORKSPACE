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
