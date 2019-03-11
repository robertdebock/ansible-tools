#!/bin/sh

echo "Remove ara callback plugin"
sed -i '/config_options/,+2 d' molecule/*/molecule.yml

git add molecule/*/molecule.yml
git commit -m "Remote config_options for simpler code."
