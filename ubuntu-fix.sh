#!/bin/sh

role=$(grep role_name meta/main.yml | awk '{print $NF}')

# Fix molecule/default:
sed -i "s/ubuntu-artful/ubuntu-latest/;s/ubuntu:artful/ubuntu:latest\n  - name: $role-ubuntu-rolling\n    image: ubuntu:rolling/" molecule/default/molecule.yml

# Rename and fix molecule/ubuntu-artful to molecule-rolling
mv molecule/ubuntu-artful molecule/ubuntu-rolling
sed -i "s/artful/rolling/g" molecule/ubuntu-rolling/molecule.yml

# Fix travis
sed -i "s/artful/rolling/g"  .travis.yml

# Regenerate README.md
../ansible-tools/generate_readme.yml -e pwd=$(pwd)

# Add, commit & push.
git add .
git commit -m "For Ubuntu, test latest, rolling and devel."
git push
