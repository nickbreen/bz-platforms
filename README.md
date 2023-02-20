# Set Up

- [bazelisk](https://github.com/bazelbuild/bazelisk/releases) installed to `~/.local/bin/bazel`. 
- [buildifer and buildozer](https://github.com/bazelbuild/buildtools/releases) installed to `~/.local/bin/buildifier` 
  and `~/local/bin/buildozer`. 
- IntelliJ Ultimate with Bazel plugin. File > Import Bazel Project.

# References

Derived from https://github.com/hlopko/bazel_platforms_examples.

# What?

Figure out how to define several execution platforms that will be used to generate artifacts that target those same 
platforms.

I.e. generate an artifact on debian for debian, on fedora for fedora, regardless of the host.

# Why?

This is of particular value to anyone trying to generate an RPM, as the 'specification' of an RPM's compatibility 
with a target system is "defined" as whatever `rpmbuild` produces on those systems; _glances at bootstrap paradox_.

# How?

`BUILD.bazel` defines a set of [platforms](https://bazel.build/extending/platforms) and a set of
[toolchains](https://bazel.build/reference/be/platforms-and-toolchains).

The platforms are _targeted_ with [--platforms](https://bazel.build/reference/command-line-reference#flag--platforms) 
in `.bazelrc` for the various configs we build with.

Just run `./test.sh` and see it work.

## Target Compatibility vs. Execution Compatibility

As per [Platforms](https://bazel.build/extending/platforms):
> Bazel recognizes three roles that a platform may serve:
> - **Host** - the platform on which Bazel itself runs.
> - **Execution** - a platform on which build tools execute build actions to produce intermediate and final outputs.
> - **Target** - a platform on which a final output resides and executes.

For trivial projects these will all be the same platform: `@local_config_platform//:host`.

We have several platforms, one for each `//dist:*`, we need an executor for each of these: otherwise targets will be 
built once for the first platform and cached for the subsequent platforms. Each platform specifies the docker image 
that the docker strategy must use as the executor. We've built these images with `./images.sh`.

Our host is actually capable of executing all of these with the docker strategy, otherwise we'd need a remote executor 
host for each execution platform. We indicate this in `WORKSPACE` by 
[registering all our execution platforms](https://bazel.build/rules/lib/globals#register_execution_platforms()).
