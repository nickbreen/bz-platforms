#!/bin/bash

docker build --rm --tag executor:debian - <<'EOF'
FROM debian:stable-slim
RUN getent group 100 | { IFS=: read group _ gid; groupdel $group; }
EOF

docker build --rm --tag executor:fedora - <<'EOF'
FROM fedora:37
RUN yum install -y /usr/bin/rpmbuild /usr/bin/python3 && yum clean all
RUN getent group 100 | { IFS=: read group _ gid; userdel games; groupdel $group; }
EOF

docker build --rm --tag executor:ubuntu - <<'EOF'
FROM ubuntu:kinetic
RUN getent group 100 | { IFS=: read group _ gid; groupdel $group; }
EOF

docker build --rm --tag executor:rocky - <<'EOF'
FROM rockylinux:8
RUN yum install -y /usr/bin/rpmbuild /usr/bin/python3 && yum clean all
RUN getent group 100 | { IFS=: read group _ gid; userdel games; groupdel $group; }
EOF

docker build --rm --tag executor:centos --file - images/centos/6 <<'EOF'
FROM centos:6

RUN rm /etc/yum.repos.d/*

# From https://www.getpagespeed.com/files/centos6-eol.repo
# From https://www.getpagespeed.com/files/centos6-epel-eol.repo
ADD centos6-eol.repo centos6-epel-eol.repo /etc/yum.repos.d/
# From https://vault.epel.cloud/RPM-GPG-KEY-CentOS-6
# From https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
ADD RPM-GPG-KEY-CentOS-6 RPM-GPG-KEY-EPEL-6 /etc/pki/rpm-gpg/

RUN yum install -y /usr/bin/rpmbuild /usr/bin/python3 && yum clean all

RUN getent group 100 | { IFS=: read group _ gid; userdel games; groupdel $group; }
EOF
