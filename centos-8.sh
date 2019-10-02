#!/bin/sh

if [ -d molecule/centos-6 ] ; then
  mv molecule/centos-6 molecule/centos-7
fi

sed -i 's/6/7/g' molecule/centos-7/molecule.yml

sed -i 's/centos-6/centos-7/g' .travis.yml
