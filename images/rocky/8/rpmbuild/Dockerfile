FROM rockylinux:8

RUN yum install -y /usr/bin/rpmbuild /usr/bin/python3 && yum clean all

RUN getent group 100 | { IFS=: read group _ gid; userdel games; groupdel $group; }
