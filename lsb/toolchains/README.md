Here in `defs.bzl` define a custom generic toolchain and in `BUILD.bazel` we define several instances of that toolchain.

These exist solely for our example and they just collect a pile of string values which we'll print in our custom rule.

**Note**: a toolchain is just a [rule](https://bazel.build/extending/rules) that provides 
[ToolchainInfo](https://bazel.build/rules/lib/ToolchainInfo) which contains various values useful to actions.

One might extrapolate this example into a more complex toolchain that would have to take differences in linux distributions.

We're using it to extract the pretty-name of the OS by reading [systemd's /et/cos-release](https://www.freedesktop.org/software/systemd/man/os-release.html) file.
This file will not exist on a non-systemd OS, so an alternative source of metadata must be described. 
 