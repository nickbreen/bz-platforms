A toolchain is just a [rule](https://bazel.build/extending/rules) that provides 
[ToolchainInfo](https://bazel.build/rules/lib/ToolchainInfo) which contains various values useful to actions.

We're using it to extract the pretty-name of the OS by:

1. reading [systemd's /et/cos-release](https://www.freedesktop.org/software/systemd/man/os-release.html) file.
2. reading `/etc/redhat-release` file provided by the `centos-release` package.

Another option maybe to use the `lsb_release` binary provided by the `lsb-release` package on many OS's.
