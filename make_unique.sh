#!/bin/sh

role_name=$(pwd | awk -F\- '{ print $NF }')

sed -i -E "s/  - name: ${role_name}-(.*)/  - name: ${role_name}-default-\1/" molecule/default/molecule.yml
