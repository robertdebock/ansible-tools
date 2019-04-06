#!/bin/sh

echo "Running $0"

role_name=$(basename $(pwd) | cut -d- -f3-)
echo "Working on ${role_name}"

echo "Place the prepare.yml playbook"
for scenario in molecule/* ; do
  if [ ! -f ${scenario}/prepare.yml ] ; then
    if [ -f ${scenario}/playbook.yml ] ; then
      cp ${scenario}/playbook.yml ${scenario}/prepare.yml
      sed -i "/ansible-role-${role_name}/d" ${scenario}/prepare.yml
      sed -i 's/Converge/Prepare/' ${scenario}/prepare.yml
      cat << EOF > ${scenario}/playbook.yml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - ansible-role-${role_name}
EOF
    fi
  fi
done

echo "Use yes/no instead of true/false in prepare.yml"
sed -i 's/false/no/;s/true/yes/' molecule/*/prepare.yml molecule/*/playbook.yml
