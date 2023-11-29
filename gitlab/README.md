# GitLab tools

For a single role:

```shell
export ROLE=ansible-role-tailscale

./gitlab-pull-mirror.yml \
  --extra-vars role="${ROLE}" \
  --ask-vault-pass

./gitlab.yml \
  --extra-vars role="${ROLE}" \
  --ask-vault-pass
```

For all roles:

```shell
test -f /tmp/vault-pass || exit 1
ls -d ../../ansible-role-* | cut -d/ -f3 | while read ROLE ; do
  # ./gitlab-pull-mirror.yml \
  #   --extra-vars role="${ROLE}" \
  #   --vault-password-file /tmp/vault-pass

  ./gitlab.yml \
    --extra-vars role="${ROLE}" \
    --vault-password-file /tmp/vault-pass
  sleep 35
done
```
