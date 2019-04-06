#!/bin/sh

echo "Running $0"

role_name=$(basename $(pwd) | cut -d- -f3-)
echo "Working on ${role_name}"

echo "Create resources directory"
if [ ! -d molecule/resources ] ; then
  mkdir molecule/resources
fi

echo "Copy default playbook.yml to resources directory"
if [ -f molecule/default/playbook.yml ] ; then
  if [ ! -f molecule/resources/playbook.yml ] ; then
    cp molecule/default/playbook.yml molecule/resources/
  fi
fi

echo "Copy default prepare.yml to resources directory"
if [ -f molecule/default/prepare.yml ] ; then
  if [ ! -f molecule/resources/prepare.yml ] ; then
    cp molecule/default/prepare.yml molecule/resources/
  fi
fi

echo "Remove nearly all playbook.yml, prepare.yml and Dockerfile.j2"
ls molecule | grep -v resources | while read scenario ; do
  test -f molecule/${scenario}/playbook.yml && rm molecule/${scenario}/playbook.yml
  test -f molecule/${scenario}/prepare.yml && rm molecule/${scenario}/prepare.yml
  test -f molecule/${scenario}/Dockerfile.j2 && rm molecule/${scenario}/Dockerfile.j2
done

# These two action better come from generate_molecule.yml
#echo "Refer molecule to the resources directory"
#sed -i 's%^  name: ansible$%  name: ansible\n  playbooks:\n    prepare: ../resources/prepare.yml\n    converge: ../resources/playbook.yml%'

#echo "Mark instances as pre_build_image."
#sed 's/^(    image: .*)/\1\n    pre_build_image: yes/' 
