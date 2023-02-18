Here in `defs.bzl` define a custom generic toolchain and in `BUILD.bazel` we define several instances of that toolchain.

These exist solely for our example and they just collect a pile of string values which we'll print in our custom rule.

**Note**: a toolchain is just a [rule](https://bazel.build/extending/rules) that provides 
[ToolchainInfo](https://bazel.build/rules/lib/ToolchainInfo) which contains various values useful to actions.
