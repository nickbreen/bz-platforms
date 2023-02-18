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
        cmd = ctx.attr.cmd,
    )]

lsb_toolchain = rule(
    implementation = _lsb_toolchain,
    attrs = {
        "target_cpu": attr.label(),
        "target_os": attr.label(),
        "target_dist": attr.label(),
        "exec_cpu": attr.label(),
        "exec_os": attr.label(),
        "exec_dist": attr.label(),
        "src": attr.string(default = "/etc/os-release"),
        "cmd": attr.string(default = """. $1; echo ${!3} > $2"""),
    },
    doc = """
    A toolchain that encapsulates the source of [os-release](http://0pointer.de/public/systemd-man/os-release.html) metadata defined by the OS vendor.
    """,
)
