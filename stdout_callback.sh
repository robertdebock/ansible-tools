#!/bin/sh

for scenario in molecule/* ; do
  grep 'stdout_callback: yaml' ${scenario}/molecule.yml > /dev/null 2>&1 || sed -i 's/scenario:/  config_options:\n    defaults:\n      stdout_callback: yaml\n      bin_ansible_callbacks: true\nscenario:/' ${scenario}/molecule.yml
done
