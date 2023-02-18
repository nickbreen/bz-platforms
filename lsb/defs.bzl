def _lsb(ctx):
    toolchain = ctx.toolchains["//tools:toolchain_type"]

    print("%s: %s %s %s" % (ctx.attr.name, "target", "cpu", toolchain.target["cpu"]))
    print("%s: %s %s %s" % (ctx.attr.name, "target", "dist", toolchain.target["dist"]))
    print("%s: %s %s %s" % (ctx.attr.name, "target", "os", toolchain.target["os"]))

    print("%s: %s %s %s" % (ctx.attr.name, "exec", "cpu", toolchain.exec["cpu"]))
    print("%s: %s %s %s" % (ctx.attr.name, "exec", "dist", toolchain.exec["dist"]))
    print("%s: %s %s %s" % (ctx.attr.name, "exec", "os", toolchain.exec["os"]))

    ctx.actions.run_shell(
        mnemonic = "LSB",
        command = """
        . /etc/os-release; echo ${!2} > $1
        """,
        arguments = [ctx.actions.args().add(ctx.outputs.out).add(ctx.attr.prop)],
        outputs = [ctx.outputs.out],
    )

lsb = rule(
    implementation = _lsb,
    attrs = {
        "out": attr.output(mandatory = True),
        "prop": attr.string(mandatory = True),
    },
    toolchains = ["//tools:toolchain_type"],
)

def _lsb_test(ctx):
    toolchain = ctx.toolchains["//tools:toolchain_type"]

    print("%s: %s %s %s" % (ctx.attr.name, "target", "cpu", toolchain.target["cpu"]))
    print("%s: %s %s %s" % (ctx.attr.name, "target", "dist", toolchain.target["dist"]))
    print("%s: %s %s %s" % (ctx.attr.name, "target", "os", toolchain.target["os"]))

    print("%s: %s %s %s" % (ctx.attr.name, "exec", "cpu", toolchain.exec["cpu"]))
    print("%s: %s %s %s" % (ctx.attr.name, "exec", "dist", toolchain.exec["dist"]))
    print("%s: %s %s %s" % (ctx.attr.name, "exec", "os", toolchain.exec["os"]))

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
        "regexp": attr.bool(default = False),
        "expected": attr.string(mandatory = True),
    },
    toolchains = ["//tools:toolchain_type"],
)
