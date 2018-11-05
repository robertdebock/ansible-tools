Tools
=====

Tools I use to create and manage Ansible roles.

README.md generator
-------------------
The README.md contains stuff that's already described somewhere else, such as:
- Purpose (meta/main.yml)
- Requirements (requirements.yml)
- Variables (default/main.yml)
- Examples (molecule/default/playbook.yml)
- License (meta/main.yml)
- Compatibility (.travis.yml)

The `generate_readme.yml` helps to create a consistent README.

```
# In the directory of your role:
./generate_readme.yml -e pwd=$(pwd)
```
