#!/bin/sh

echo "Running $0"
echo "Remove _ignore_docker from tasks/*.yml and handlers/main.yml"
sed -i 's/ or .*_ignore_docker//' tasks/*.yml
sed -i '/_ignore_docker/d' tasks/*.yml
if [ -f handlers/main.yml ] ; then
  sed -i 's/ or .*_ignore_docker//' handlers/main.yml
fi

echo "Remove _ignore_docker from defaults/main.yml"
sed -i '/Some Docker containers/d' defaults/main.yml
sed -i '/to some locations in/d' defaults/main.yml
sed -i '/Docker. With this parameter/d' defaults/main.yml
sed -i '/ignore_docker:/d' defaults/main.yml

echo "Remove empty last line"
sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' defaults/main.yml
