#!/bin/sh -x

normal_scenarios="centos-6 centos-lastest debian-latest debian-stable debian-unstable fedora-latest fedora-rawhide opensuse-leap ubuntu-devel ubuntu-latest ubuntu-rolling"

only_privileged_scenarios="archlinux"

command_scenarios="alpine-edge alpine-latest"

multi_scenarios="default"

# Remove "when docker" from tasks and handlers.

for scenario in ${normal_scenarios} ; do
  sed -i 's%pre_build_image: yes%pre_build_image: yes\n    command: /sbin/init\n    privileged: yes%' molecule/${scenario}/molecule.yml
done

for scenario in ${command_scenarios} ; do
  sed -i '/command: /d' molecule/${scenario}/molecule.yml
  sed -i 's%pre_build_image: yes%pre_build_image: yes\n    command: /sbin/init\n    privileged: yes%' molecule/${scenario}/molecule.yml
done

for scenario in ${only_privileged_scenarios} ; do
  sed -i 's%pre_build_image: yes%pre_build_image: yes\n    privileged: yes%' molecule/${scenario}/molecule.yml
done

# Work multi_scenario
