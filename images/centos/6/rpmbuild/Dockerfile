FROM centos:6

RUN rm /etc/yum.repos.d/*

# From https://www.getpagespeed.com/files/centos6-eol.repo
ADD centos6-eol.repo /etc/yum.repos.d/
# From https://www.getpagespeed.com/files/centos6-epel-eol.repo
ADD centos6-epel-eol.repo /etc/yum.repos.d/
# From https://vault.epel.cloud/RPM-GPG-KEY-CentOS-6
ADD RPM-GPG-KEY-CentOS-6 /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
# From https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
ADD RPM-GPG-KEY-EPEL-6 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

RUN yum install -y /usr/bin/rpmbuild /usr/bin/python3 && yum clean all
