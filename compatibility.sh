#!/bin/sh -x

echo "This role has been tested against the following distributions and Ansible version:"
echo ""
echo "|distribution|ansible 2.7|ansible 2.8|ansible devel|"
echo "|------------|-----------|-----------|-------------|"
cat .travis.yml | docker run -i --rm jlordiales/jyparser get ".env" | while read dash version distro rest ; do
  echo "${distro}" | cut -d\" -f2 | sort | uniq | while read distribution ; do
  case "${distribution}" in
    alpine-edge)
      distribution='alpine-edge*'
    ;;
    debian-unstable)
      distribution='debian-unstable*'
    ;;
    fedora-rawhide)
      distribution='fedora-rawhide*'
    ;;
    ubuntu-devel)
      distribution='ubuntu-devel*'
    ;;
  esac
  grep "${distribution}" .travis.yml | grep -v 'fail' | grep '>=2.7,<2.8' > /dev/null && previous=yes || previous=no
  grep "${distribution}" .travis.yml | grep -v 'fail' | grep 'version=\"\"' > /dev/null && current=yes || current=no
  grep "${distribution}" .travis.yml | grep -v 'fail' | grep 'version=\"devel\"' > /dev/null && devel='yes*' || devel='no*'
  echo "|${distribution}|${previous}|${current}|${devel}|"
 done
done | sort | uniq
echo
echo "A single star means the build may fail, it's marked as an experimental build."
