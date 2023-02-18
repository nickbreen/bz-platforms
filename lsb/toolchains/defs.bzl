def _lsb_toolchain(ctx):
    return [platform_common.ToolchainInfo(
        target = dict(
            cpu = ctx.attr.target_cpu,
            os = ctx.attr.target_os,
            dist = ctx.attr.target_dist,
        ),
        exec = dict(
            cpu = ctx.attr.exec_cpu,
            os = ctx.attr.exec_os,
            dist = ctx.attr.exec_dist,
        ),
        src = ctx.attr.src,
    )]

lsb_toolchain = rule(
    implementation = _lsb_toolchain,
    attrs = {
        "target_cpu": attr.label(mandatory = True),
        "target_os": attr.label(mandatory = True),
        "target_dist": attr.label(mandatory = True),
        "exec_cpu": attr.label(mandatory = True),
        "exec_os": attr.label(mandatory = True),
        "exec_dist": attr.label(mandatory = True),
        "src": attr.string(default = "/etc/os-release"),
    },
    doc = """
    A toolchain that encapsulates the source of [os-release](http://0pointer.de/public/systemd-man/os-release.html) metadata defined by the OS vendor.
    """,
)
