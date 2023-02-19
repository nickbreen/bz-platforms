In `BUILD.bazel` we define a custom [toolchain_type](https://bazel.build/reference/be/platforms-and-toolchains#toolchain_type), 
conventionally named `toolchain_type` and differentiated by its package. This is the "toolchain" that we will use to
propagate various string values around.  

In `defs.bzl` we define our custom [rules](https://bazel.build/extending/rules) they require bazel to resolve a toolchain
of type `//lsb:toolchain_type`.

In `BUILD.bazel` we use the `lsb` rule and define `:pretty-name` which will extract the execution platform's pretty name
from it's LSB metadata, we do the same with `:name`. These build rules are compatible with all execution and target
platforms so we do not constrain compatibilty for these artifacts.  

We then define several `lsb_tests` that, crucially, constrain the `//dist:*` they are compatible with and check that 
the extracted pretty name is more-or-less and name is exactly what one would expect.


