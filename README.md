# Set Up

- [bazelisk](https://github.com/bazelbuild/bazelisk/releases) installed to `~/.local/bin/bazel`. 
- [buildifer and buildozer](https://github.com/bazelbuild/buildtools/releases) installed to `~/.local/bin/buildifier` 
- and `~/local/bin/buildozer`. 
- IntelliJ Ultimate with Bazel plugin. Import a new Bazel project.

# References

Derived from https://github.com/hlopko/bazel_platforms_examples.

# What?

Figure out how to define several execution environments that will be used to generate artifacts that target those same 
environments.

I.e. generate an artifact on debian for debian, on fedora for fedora, regardless of the host.

This is of particular value to anyone trying to generate an RPM, as the 'specification' of an RPM's compatibility 
with a target system is "defined" as whatever `rpmbuild` produces on those systems; _glances at bootstrap paradox_.

# How?

`BUILD.bazel` defines a set of [platforms](https://bazel.build/extending/platforms) and a set of
[toolchains](https://bazel.build/reference/be/platforms-and-toolchains).

These are enabled in `.bazelrc` for the various configurations we build with.