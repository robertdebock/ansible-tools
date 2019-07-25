#!/bin/sh

sed -i '/debian-latest/d' .travis.yml

if [ -d molecule/debian-latest ] ; then
  rm -Rf molecule/debian-latest
fi

sed -i '/debian-latest/,+2 d' molecule/default/molecule.yml
