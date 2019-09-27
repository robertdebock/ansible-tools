#!/bin/sh

for scenario in fedora-{latest,rawhide} ubuntu-{rolling,latest} debian-stable; do
  grep "ansible_python_interpreter" molecule/${scenario}/molecule.yml > /dev/null
  if [ "$?" = "1" ] ; then
    # sed -i 's%ansible-lint%ansible-lint\n  inventory:\n    group_vars:\n      all:\n        ansible_python_interpreter: /usr/bin/python3%' molecule/${scenario}/molecule.yml
    sed -i "s%scenario:%  inventory:\n    group_vars:\n      all:\n        ansible_python_interpreter: /usr/bin/python3\nscenario:%" molecule/${scenario}/molecule.yml
  fi
done

rolename=$(basename $(echo $(pwd) | cut -d- -f 3))

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
