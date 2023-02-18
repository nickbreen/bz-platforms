def _lsb(ctx):
    toolchain = ctx.toolchains["//lsb:toolchain_type"]

    str = "%s: %s %s %s"

    print(str % (ctx.attr.name, "target", "cpu", toolchain.target["cpu"]))
    print(str % (ctx.attr.name, "target", "dist", toolchain.target["dist"]))
    print(str % (ctx.attr.name, "target", "os", toolchain.target["os"]))

    print(str % (ctx.attr.name, "exec", "cpu", toolchain.exec["cpu"]))
    print(str % (ctx.attr.name, "exec", "dist", toolchain.exec["dist"]))
    print(str % (ctx.attr.name, "exec", "os", toolchain.exec["os"]))

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

def _lsb_test(ctx):
    toolchain = ctx.toolchains["//lsb:toolchain_type"]

    str = "%s: %s %s %s"

    print(str % (ctx.attr.name, "target", "cpu", toolchain.target["cpu"]))
    print(str % (ctx.attr.name, "target", "dist", toolchain.target["dist"]))
    print(str % (ctx.attr.name, "target", "os", toolchain.target["os"]))

    print(str % (ctx.attr.name, "exec", "cpu", toolchain.exec["cpu"]))
    print(str % (ctx.attr.name, "exec", "dist", toolchain.exec["dist"]))
    print(str % (ctx.attr.name, "exec", "os", toolchain.exec["os"]))

    tpl = ctx.actions.declare_file("%s.tpl" % ctx.attr.name)
    ctx.actions.write(output = tpl, is_executable = False, content = """#!/bin/bash -xe\n[[ "$(<SRC)" =~ EXP ]]""" if ctx.attr.regexp else """#!/bin/bash -xe\n[[ "$(<SRC)" == "EXP" ]]""")

    exe = ctx.actions.declare_file("%s.sh" % ctx.attr.name)
    ctx.actions.expand_template(template = tpl, output = exe, is_executable = True, substitutions = {"SRC": ctx.file.src.short_path, "EXP": ctx.attr.expected})

    return [DefaultInfo(
        executable = exe,
        runfiles = ctx.runfiles(
            files = [
                ctx.file.src,
            ],
        ),
    )]

lsb_test = rule(
    implementation = _lsb_test,
    test = True,
    attrs = {
        "src": attr.label(mandatory = True, allow_single_file = True),
        "regexp": attr.bool(default = False, doc = """is `expected` a BASH regular expression or a literal string?"""),
        "expected": attr.string(mandatory = True),
    },
    toolchains = ["//lsb:toolchain_type"],
    doc = """
    Check that the content of the `src` file is exactly (`regexp = False`) or more-or-less (`regexp = True`) what one
    would expect.
    """,
)
