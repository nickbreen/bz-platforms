def _lsb_toolchain(ctx):
    return [platform_common.ToolchainInfo(
        src = ctx.attr.src,
        cmd = ctx.attr.cmd,
    )]

lsb_toolchain = rule(
    implementation = _lsb_toolchain,
    attrs = {
        "src": attr.string(mandatory = True),
        "cmd": attr.string(mandatory = True),
    },
    doc = """
    A toolchain that encapsulates the source of LSB metadata defined by the OS vendor and how to extract it.
    """,
)

def _lsb(ctx):
    toolchain = ctx.toolchains["//lsb:toolchain_type"]

    ctx.actions.run_shell(
        mnemonic = "LSB",
        command = toolchain.cmd,
        arguments = [ctx.actions.args().add(toolchain.src).add(ctx.outputs.out).add(ctx.attr.prop)],
        outputs = [ctx.outputs.out],
    )

lsb = rule(
    implementation = _lsb,
    attrs = {
        "out": attr.output(mandatory = True),
        "prop": attr.string(mandatory = True),
    },
    toolchains = ["//lsb:toolchain_type"],
    doc = """
    Extract the specified property (`prop`) from the LSB os-release metadata.
    """,
)

_regexp_test = """#!/bin/bash -xe
[[ "$(<SRC)" =~ EXP ]]
"""

_string_test = """#!/bin/bash -xe
[[ "$(<SRC)" == "EXP" ]]
"""

def _lsb_test(ctx):
    toolchain = ctx.toolchains["//lsb:toolchain_type"]

    tpl = ctx.actions.declare_file("%s.tpl" % ctx.attr.name)
    ctx.actions.write(output = tpl, is_executable = False, content = _regexp_test if ctx.attr.regexp else _string_test)

    exe = ctx.actions.declare_file("%s.sh" % ctx.attr.name)
    ctx.actions.expand_template(template = tpl, output = exe, is_executable = True, substitutions = {"SRC": ctx.file.data.short_path, "EXP": ctx.attr.expected})

    return [DefaultInfo(
        executable = exe,
        runfiles = ctx.runfiles(
            files = [
                ctx.file.data,
            ],
        ),
    )]

lsb_test = rule(
    implementation = _lsb_test,
    test = True,
    attrs = {
        "data": attr.label(mandatory = True, allow_single_file = True),
        "regexp": attr.bool(default = False, doc = """is `expected` a BASH regular expression or a literal string?"""),
        "expected": attr.string(mandatory = True),
    },
    toolchains = ["//lsb:toolchain_type"],
    doc = """
    Check that the content of the `data` file is exactly (`regexp = False`) or more-or-less (`regexp = True`) what one
    would expect.
    """,
)
