#!/bin/sh

# Remove molecule/opensuse-tumbleweed
rm -Rf molecule/opensuse-tumbleweed

# Remove from molecule/default.yml
sed -i '/tumbleweed/d' molecule/default/molecule.yml

# Remove from .travis.yml
sed -i '/tumbleweed/d' .travis.yml

# Recreate documentation
../ansible-tools/generate_readme.yml -e "pwd=$(pwd)"

# Git stuff
#git add .
#git commit -m "Removing opensuse-tumbleweed, it is deprecated."
#git push
