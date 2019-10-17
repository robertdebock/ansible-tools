#!/bin/sh

move_playbooks_to_default() {
# Move prepare.yml and playbook.yml to default scenario
for playbook in prepare.yml playbook.yml ; do
  if [ -d molecule/resources ] ; then
    mv molecule/resources/${playbook} molecule/default/${playbook}
  fi
done
}

remove_other_scenarios() {
# Remove all but "default" scenario.
cd molecule
for scenario in * ; do
  if [ ${scenario} != default ] ; then
    rm -Rf ${scenario}
  fi
done
cd ..
}

# Save the secret listed in .travis.yml
secret=$(grep secure .travis.yml | cut -d\" -f2)

place_travis_yml() {
# Place .travis.yml
echo "---" > .travis.yml
echo "language: python" >> .travis.yml
echo "" >> .travis.yml
echo "python:" >> .travis.yml
echo "  - \"3.7\"" >> .travis.yml
echo "" >> .travis.yml
echo "services:" >> .travis.yml
echo "  - docker" >> .travis.yml
echo "" >> .travis.yml
echo "env:" >> .travis.yml
echo "  matrix:" >> .travis.yml
echo "    - distribution=\"alpine:latest\"" >> .travis.yml
echo "    - distribution=\"alpine:edge\"" >> .travis.yml
echo "    - distribution=\"archlinux/base\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-centos-systemd:7\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-centos-systemd:latest\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-debian-systemd:latest\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-debian-systemd:stable\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-debian-systemd:unstable\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-fedora-systemd:latest\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-fedora-systemd:rawhide\"" >> .travis.yml
echo "    - distribution=\"opensuse/leap\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-ubuntu-systemd:latest\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-ubuntu-systemd:devel\"" >> .travis.yml
echo "    - distribution=\"robertdebock/docker-ubuntu-systemd:rolling\"" >> .travis.yml
echo "" >> .travis.yml
echo "matrix:" >> .travis.yml
echo "  allow_failures:" >> .travis.yml
echo "    - env: distribution=\"alpine:edge\"" >> .travis.yml
echo "    - env: distribution=\"robertdebock/docker-debian-systemd:unstable\"" >> .travis.yml
echo "    - env: distribution=\"robertdebock/docker-fedora-systemd:rawhide\"" >> .travis.yml
echo "    - env: distribution=\"robertdebock/docker-ubuntu-systemd:devel\"" >> .travis.yml
echo "" >> .travis.yml
echo "cache:" >> .travis.yml
echo "  - pip" >> .travis.yml
echo "" >> .travis.yml
echo "install:" >> .travis.yml
echo "  - pip install --upgrade pip" >> .travis.yml
echo "  - pip install molecule" >> .travis.yml
echo "  - pip install tox" >> .travis.yml
echo "" >> .travis.yml
echo "script:" >> .travis.yml
echo "  - tox --parallel all" >> .travis.yml
echo"" >> .travis.yml
echo "notifications:" >> .travis.yml
echo "  webhooks: https://galaxy.ansible.com/api/v1/notifications/" >> .travis.yml
echo "  slack:" >> .travis.yml
echo "    secure: \"${secret}\"" >> .travis.yml
echo "  email: false" >> .travis.yml
}

place_molecule_yml() {
# Place molecule/default/molecule.yml
echo "---" > molecule/default/molecule.yml
echo "dependency:" >> molecule/default/molecule.yml
echo "  name: galaxy" >> molecule/default/molecule.yml
echo "  options:" >> molecule/default/molecule.yml
echo "    role-file: requirements.yml" >> molecule/default/molecule.yml
echo "lint:" >> molecule/default/molecule.yml
echo "  name: yamllint" >> molecule/default/molecule.yml
echo "driver:" >> molecule/default/molecule.yml
echo "  name: docker" >> molecule/default/molecule.yml
echo "platforms:" >> molecule/default/molecule.yml
echo "  - name: \"instance-\${TOX_ENVNAME:-default}\"" >> molecule/default/molecule.yml
echo "    image: \"\${distribution:-robertdebock/docker-fedora-systemd:latest}\"" >> molecule/default/molecule.yml
echo "    command: sh -c \"while true ; do sleep 30 ; done\"" >> molecule/default/molecule.yml
echo "    pre_build_image: yes" >> molecule/default/molecule.yml
echo "provisioner:" >> molecule/default/molecule.yml
echo "  name: ansible" >> molecule/default/molecule.yml
echo "  playbooks:" >> molecule/default/molecule.yml
echo "    prepare: prepare.yml" >> molecule/default/molecule.yml
echo "    converge: playbook.yml" >> molecule/default/molecule.yml
echo "  inventory:" >> molecule/default/molecule.yml
echo "    group_vars:" >> molecule/default/molecule.yml
echo "      all:" >> molecule/default/molecule.yml
echo "        ansible_python_interpreter: /usr/bin/python3" >> molecule/default/molecule.yml
echo "scenario:" >> molecule/default/molecule.yml
echo "  name: default" >> molecule/default/molecule.yml
}

place_tox_ini() {
echo "[tox]" > tox.ini
echo "minversion = 3.7" >> tox.ini
echo "envlist = py{37}-ansible-{previous,current,next}" >> tox.ini
echo "skipsdist = true" >> tox.ini
echo "" >> tox.ini
echo "[testenv]" >> tox.ini
echo "deps =" >> tox.ini
echo "    previous: ansible~=2.7" >> tox.ini
echo "    current: ansible~=2.8" >> tox.ini
echo "    next: git+https://github.com/ansible/ansible.git@devel" >> tox.ini
echo "    docker" >> tox.ini
echo "    molecule" >> tox.ini
echo "commands =" >> tox.ini
echo "    molecule test" >> tox.ini
echo "setenv =" >> tox.ini
echo "    TOX_ENVNAME={envname}" >> tox.ini
echo "    MOLECULE_EPHEMERAL_DIRECTORY=/tmp/{envname}" >> tox.ini
}

add_tox_ini_to_git_ignore() {
grep .tox .gitignore 2> /dev/null || echo ".tox" >> .gitignore
}

move_playbooks_to_default
remove_other_scenarios
place_travis_yml
place_molecule_yml
place_tox_ini
add_tox_ini_to_git_ignore
