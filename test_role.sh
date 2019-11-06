#!/bin/sh

results_directory="~/Documents"
role=$(basename $(pwd))

testrole() {
  # Create a file if it does not exist
  test -f ${results_directory}/{image}-{tag:-latest}.txt || \
  touch ${results_directory}/{image}-{tag:-latest}.tx
  # See if the role was already tested (and worked).
  grep ${role} ${results_directory}/{image}-{tag:-latest}.txt > /dev/null 2>&1 || \
  # Test the role.
  molecule test && echo ${role} >> ${results_directory}/{image}-{tag:-latest}.txt
}

# This is the list of images and tags to test.
image=amazonlinux tag=1 testrole
image=amazonlinux tag=2 testrole
image=alpine testrole
image=alpine tag=edge testrole
image=centos testrole
image=centos tag=7 testrole
image=debian testrole testrole
image=debian tag=stable testrole
image=debian tag=unstable testrole
image=oraclelinux tag=7 testrole
image=fedora testrole
image=fedora tag=30 testrole
image=fedora tag=31 testrole
image=fedora tag=rawhide testrole
image=opensuse testrole
image=oraclelinux testrole
image=redhat tag=7 testrole
image=redhat testrole testrole
image=ubuntu testrole
image=ubuntu tag=rolling testrole
image=ubuntu tag=devel testrole
