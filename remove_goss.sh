#!/bin/sh

echo "Remove verifier section from molecule.yml"
sed -i '/verifier:/,+4 d' molecule/*/molecule.yml

echo "Remove tests directory"
rm -Rf molecule/*/tests

echo "Remove verify.yml"
rm molecule/*/verify.yml

git add .
git commit -m "Removing GOSS tests as they can't test as flexible as required."
