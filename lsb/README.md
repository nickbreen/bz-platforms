# Toolchains

In `BUILD.bazel` we define a custom [toolchain_type](https://bazel.build/reference/be/platforms-and-toolchains#toolchain_type), 
conventionally named `toolchain_type` and differentiated by its package. This is the "toolchain" that we will use to
propagate various string values around. It's defined in `defs.bzl`.  

A toolchain is just a [rule](https://bazel.build/extending/rules) that provides
[ToolchainInfo](https://bazel.build/rules/lib/ToolchainInfo) which contains various values useful to actions.

We're using it to extract the pretty-name of the OS by:

1. reading [systemd's /et/cos-release](https://www.freedesktop.org/software/systemd/man/os-release.html) file.
2. reading `/etc/redhat-release` file provided by the `centos-release` package.

Another implementation maybe using `lsb_release` provided by the `lsb-release` package on many OS's.

# Targets

In `defs.bzl` we define our custom [rules](https://bazel.build/extending/rules) they require bazel to resolve a 
toolchain of type `//lsb:toolchain_type`.

In `BUILD.bazel` we use the `lsb` rule and define `:pretty-name` which will extract the execution platform's pretty 
name from it's LSB metadata, we do the same with `:name`. These build rules are compatible with all execution and target
platforms so we do not constrain compatibility for these artifacts: the toolchains are resolved for specific platforms.  

We then define a single `lsb_test` for `:name` that check the expected value, based on the `//dist:*` constraint, is
exactly what we would expect.

We also define several `lsb_test` for `:pretty-name` and `select` that, crucially, constrain the `//dist:*` they are 
compatible with and check that the extracted simple name is more-or-less what one would expect. 

This demonstrates how the explicit constraints and selected constraints are more-or-less equivalent.

Notice how bazel will mark incompatible tests as 'SKIPPED'

# Target vs Execution Compatibility

This was empirically extremely confusing; so an example may help:

`//lsb:pretty-name` is **target** compatible with all our platforms, so we've not bothered to constrain it. 

`//lsb:test/name` is **target** compatible with all but one of our platforms, its marked as incompatible for that 
platforms' `//dist:*` constraint value.

We have a test `//lsb:test/pretty-name/debian` which tests the artifact of `//lsb:pretty-name` but only when
that artifact was built on a platform that is
[target_compatible_with](https://bazel.build/reference/be/common-definitions#typical-attributes) `//dist:debian`.

We have a similar test `//lsb:test/name` which tests the artifact of `//lsb:name`; bazel only runs the test when it is
compatible. In this case one of `//dist:*` is not compatible with this test.

The `lsb` rule is compatible with all our execution platforms, so we do not constrain it. `//lsb:toolchain_type`
toolchains provide the `lsb` rule with instructions how to extract the "name" or "pretty-name".

The toolchain compatible with `//dist:debian` is defined as `//:toolchain/debian` it is suitable for use when a rule
needs to execute on a debian executor and also to target the artifact to run on debian.

I suspect if `lsb_test` was not a test but a non-executable rule its action could use the `src` as `inputs` and they'd 
be subject to **target** compatibility; if it were to use the `src` as `tools` it would be subject to **execution** 
compatibility.

# Cache

**Note** each of the `:pretty-name` target is not (locally) cached independently for each `//dist:*` and the test is 
also not (locally) cached as it's test subject changes for each bazel run with a different platform; they are all 
disk-/remote-cached independently.
