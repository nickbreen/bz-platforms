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
