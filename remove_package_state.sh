#!/bin/sh

echo "Remove _package_state from defaults/main.yml"
sed -i '/_package_state/d' defaults/main.yml

echo "Remove empty last line"
sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' defaults/main.yml

echo "Replace _package_state for present in tasks/main.yml"
sed -i 's/state: .*_package_state.*/state: present/' tasks/main.yml

echo "Generate README.md"
../ansible-tools/generate_readme.yml -e "pwd=$(pwd)"

git add defaults/main.yml
git add tasks/main.yml
git add README.md
git commit -m "Simplify the role, remove variable _package_state."
