#!/bin/sh

for scenario in alpine-{latest,edge} centos-latest fedora-{latest,rawhide} ubuntu-{rolling,latest,devel} debian-stable debian-unstable; do
  if [ -f molecule/${scenario}/molecule.yml ] ; then
    grep "ansible_python_interpreter" molecule/${scenario}/molecule.yml > /dev/null
    if [ "$?" = "1" ] ; then
      sed -i "s%scenario:%  inventory:\n    group_vars:\n      all:\n        ansible_python_interpreter: /usr/bin/python3\nscenario:%" molecule/${scenario}/molecule.yml
    fi
  fi
done

#rolename=$(basename $(echo $(pwd) | cut -d- -f 3))

# for scenario in default ; do
#   grep "ansible_python_interpreter"  molecule/${scenario}/molecule.yml
#   if [ "$?" = "1" ] ; then
#     sed "s%scenario:%  inventory:\n    group_vars:\n      all:\n        ansible_python_interpreter: /usr/bin/python3\n      \nscenario:" molecule/${scenario}/molecule.yml
#   fi
# done

# for scenario in vagrant ; do
#   sed -i 's/29-cloud-base/30-cloud-base/' molecule/${scenario}/molecule.yml
#   grep "ansible_python_interpreter"  molecule/${scenario}/molecule.yml
#   if [ "$?" = "1" ] ; then
#     sed -i "s%ansible-lint%ansible-lint\n  inventory:\n    host_vars:\n      ${rolename}-fedora:\n        ansible_python_interpreter: /usr/bin/python3%" molecule/${scenario}/molecule.yml
#   fi
# done
