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
# Go to the directory of your role:
cd /some/path/to/your/role
# Generate the README.md:
/path/to/generate_readme.yml -e pwd=$(pwd)
```
