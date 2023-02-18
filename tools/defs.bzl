def _toolchain(ctx):
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
    )]

toolchain = rule(
    implementation = _toolchain,
    attrs = {
        "target_cpu": attr.label(mandatory = True),
        "target_os": attr.label(mandatory = True),
        "target_dist": attr.label(mandatory = True),
        "exec_cpu": attr.label(mandatory = True),
        "exec_os": attr.label(mandatory = True),
        "exec_dist": attr.label(mandatory = True),
    },
)
