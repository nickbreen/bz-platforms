This is a "simpler" example of  `//lsb/...` without toolchains or custom rules.

We have a set of `genrule` that extract each distribution's pretty-name. These must be executed on a specific platform
constrained by `//dist:*` and specified with `exec_compatible_with`.

We have a set of `sh_test` that check each distribution's pretty-name. These can be executed on any platform as the 
test binary `test.sh` is just a normal bash script but only apply to the `:pretty-name/*` subject with the matching
`target_compatible_with` specification.

**Note** each of the `:pretty-name/*` targets is (locally) cached independently but the test only (locally) cached for
the last execution; they are all disk-/remote-cached independently. 