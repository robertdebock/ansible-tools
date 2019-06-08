#!/bin/sh -x

for scenario in fedora-{latest,rawhide} ; do
  grep "ansible_python_interpreter"  molecule/${scenario}/molecule.yml
  if [ "$?" = "1" ] ; then
    sed -i 's%ansible-lint%ansible-lint\n  inventory:\n    group_vars:\n      all:\n        ansible_python_interpreter: /usr/bin/python3%' molecule/${scenario}/molecule.yml
  fi
done

rolename=$(basename $(echo $(pwd) | cut -d- -f 3))

for scenario in default ; do
  grep "ansible_python_interpreter"  molecule/${scenario}/molecule.yml
  if [ "$?" = "1" ] ; then
    sed -i "s%ansible-lint%ansible-lint\n  inventory:\n    host_vars:\n      ${rolename}-fedora-latest:\n        ansible_python_interpreter: /usr/bin/python3\n      ${rolename}-fedora-rawhide:\n        ansible_python_interpreter: /usr/bin/python3%" molecule/${scenario}/molecule.yml
  fi
done
