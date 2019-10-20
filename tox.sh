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

save_secret() {
# Save the secret listed in .travis.yml
secret=$(grep secure .travis.yml | cut -d\" -f2)
}

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
echo "  global:" >> .travis.yml
echo "    - namespace=\"robertdebock/\"" >> .travis.yml
echo "  matrix:" >> .travis.yml
echo "    - image=\"docker-alpine-openrc\"" >> .travis.yml
echo "    - image=\"docker-alpine-openrc\" tag=\"edge\"" >> .travis.yml
echo "    # - namespace=\"archlinux/\" image=\"base\"" >> .travis.yml
echo "    - image=\"docker-centos-systemd\" tag=\"7\"" >> .travis.yml
echo "    - image=\"docker-centos-systemd\"" >> .travis.yml
echo "    - image=\"docker-debian-systemd\" tag=\"stable\"" >> .travis.yml
echo "    - image=\"docker-debian-systemd\" tag=\"unstable\"" >> .travis.yml
echo "    - image=\"docker-debian-systemd\"" >> .travis.yml
echo "    - image=\"docker-fedora-systemd\"" >> .travis.yml
echo "    - image=\"docker-fedora-systemd\" tag=\"rawhide\"" >> .travis.yml
echo "    - namespace=\"opensuse/\" image=\"leap\"" >> .travis.yml
echo "    - image=\"docker-ubuntu-systemd\" tag=\"rolling\"" >> .travis.yml
echo "    - image=\"docker-ubuntu-systemd\" tag=\"devel\"" >> .travis.yml
echo "    - image=\"docker-ubuntu-systemd\"" >> .travis.yml
echo "" >> .travis.yml
echo "matrix:" >> .travis.yml
echo "  allow_failures:" >> .travis.yml
echo "    - env: image=\"docker-alpine-openrc\" tag=\"edge\"" >> .travis.yml
echo "    - env: image=\"docker-debian-systemd\" tag=\"unstable\"" >> .travis.yml
echo "    - env: image=\"docker-fedora-systemd\" tag=\"rawhide\"" >> .travis.yml
echo "    - env: image=\"docker-ubuntu-systemd\" tag=\"rolling\"" >> .travis.yml
echo "    - env: image=\"docker-ubuntu-systemd\" tag=\"devel\"" >> .travis.yml
echo "" >> .travis.yml
echo "cache:" >> .travis.yml
echo "  - pip" >> .travis.yml
echo "" >> .travis.yml
echo "install:" >> .travis.yml
echo "  - pip install --upgrade pip" >> .travis.yml
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
echo "  - name: \"\${image:-default}-\${TOX_ENVNAME:-default}\"" >> molecule/default/molecule.yml
echo "    image: \"\${namespace}\${image:-docker-fedora-systemd}:\${tag:-latest}\"" >> molecule/default/molecule.yml
echo "    command: sh -c \"while true ; do sleep 30 ; done\"" >> molecule/default/molecule.yml
echo "    pre_build_image: yes" >> molecule/default/molecule.yml
echo "provisioner:" >> molecule/default/molecule.yml
echo "  name: ansible" >> molecule/default/molecule.yml
echo "  playbooks:" >> molecule/default/molecule.yml
echo "    prepare: prepare.yml" >> molecule/default/molecule.yml
echo "    converge: playbook.yml" >> molecule/default/molecule.yml
echo "scenario:" >> molecule/default/molecule.yml
echo "  name: default" >> molecule/default/molecule.yml
}

place_tox_ini() {
echo "[tox]" > tox.ini
echo "minversion = 3.7" >> tox.ini
echo "envlist = py{37}-ansible-{current,next}" >> tox.ini
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
echo "passenv = namespace image tag" >> tox.ini
}

add_tox_ini_to_git_ignore() {
grep .tox .gitignore 2> /dev/null 1>&2 || echo ".tox" >> .gitignore
}

move_playbooks_to_default
remove_other_scenarios
save_secret
place_travis_yml
place_molecule_yml
place_tox_ini
add_tox_ini_to_git_ignore
