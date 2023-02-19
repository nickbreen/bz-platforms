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

The platforms are _targeted_ with [--platforms](https://bazel.build/reference/command-line-reference#flag--platforms) 
in `.bazelrc` for the various configs we build with.

# Target Compatibility vs. Execution Compatibility

As per [Platforms](https://bazel.build/extending/platforms):
> Bazel recognizes three roles that a platform may serve:
> - **Host** - the platform on which Bazel itself runs.
> - **Execution** - a platform on which build tools execute build actions to produce intermediate and final outputs.
> - **Target** - a platform on which a final output resides and executes.

This was empirically extremely confusing.

We have several execution platforms, one for each `//dist:*`, we need an executor for each of these: otherwise 
`//lsb:*` will be built once for the first platform and cached for the subsequent platforms. 

Our host is actually capable of executing all of these with the docker strategy, otherwise we'd need a remote executor 
host for each execution platform. We indicate this in `WORKSPACE` by registering all our execution platforms 
with [register_execution_platforms()](https://bazel.build/rules/lib/globals#register_execution_platforms()).

We also need _target_ platforms to match the `//dist:*` constraints to indicate that each `//lsb:*` can only be used or
consumed on that platform.

Again, extremely confusing. So an example may help:

We have a test `//lsb:test/name/debian` which tests the artifact of `//lsb:name` but only when that artifact was 
built on a platform that is
[target_compatible_with](https://bazel.build/reference/be/common-definitions#typical-attributes) `//dist:debian`. 

`//lsb:name` is compatible with all our execution platforms, so we do not constrain it. The `//lsb:defs.bzl` 
rule `lsb` requires a toolchain to provide the `lsb` rule's action with instructions how to extract the "name".

The toolchain that is compatible with `//dist:debian` is defined as `//:toolchain/debian` it is suitable for use when
a rule needs to execute on a debian executor and also to target the artifact to run on debian.

We can only specify one docker image on the command line, so we partition up the variations in `/bazelrc` with
config sections; e.g.:

```
build:debian --platforms=//:platform/linux/debian
build:debian --experimental_docker_image=debian:stable-slim
```

# Alternatives

We didn't need to define toolchains, could we have just defined a set of `genrules` that were execution or 
target compatible?






