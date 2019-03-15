#!/bin/sh

echo "Place the prepare.yml playbook"
for scenario in molecule/* ; do
  cat << EOF > ${scenario}/prepare.yml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - robertdebock.bootstrap
EOF
done

echo "Remove the bootstrap line from playbook.yml"
sed -i '/robertdebock.bootstrap/d' molecule/*/playbook.yml

echo "Set gather_facts to yes in playbook.yml"
sed -i 's/gather_facts:.*/gather_facts: yes/' molecule/*/playbook.yml

echo "Use yes/no instead of true/false in playbook.yml"
sed -i 's/false/no/;s/true/yes/' molecule/*/playbook.yml
