#!/bin/bash

docker build --rm -t rocky:8-rpmbuild images/rocky/8/rpmbuild
docker build --rm -t centos:6-rpmbuild images/centos/6/rpmbuild
