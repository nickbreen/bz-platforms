#!/bin/bash

docker build --rm --tag executor:debian - <<'EOF'
FROM debian:stable-slim
RUN getent group 100 | { IFS=: read group _ gid; groupdel $group; }
EOF

docker build --rm --tag executor:fedora - <<'EOF'
FROM fedora:37
RUN getent group 100 | { IFS=: read group _ gid; userdel games; groupdel $group; }
EOF

docker build --rm --tag executor:ubuntu - <<'EOF'
FROM ubuntu:kinetic
RUN getent group 100 | { IFS=: read group _ gid; groupdel $group; }
EOF

docker build --rm --tag executor:rocky images/rocky/8/rpmbuild
docker build --rm --tag executor:centos images/centos/6/rpmbuild
