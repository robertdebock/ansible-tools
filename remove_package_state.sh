#!/bin/sh

echo "Running $0"

echo "Remove _package_state from defaults/main.yml"
sed -i '/_package_state/d' defaults/main.yml

echo "Remove empty last line"
sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' defaults/main.yml

echo "Replace _package_state for present in tasks/main.yml"
sed -i 's/state: .*_package_state.*/state: present/' tasks/main.yml

echo "Remove _package_state lines in tasks/main.yml"
sed -i '/_package_state/d' tasks/main.yml
