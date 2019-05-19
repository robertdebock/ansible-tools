string=$(travis encrypt "robertdebock:w34z0j0QFIVI4S0osys2GZ3W" --no-interactive 2>/dev/null) ; sed -i 's%secure: .*%secure: '"${string}"'%' .travis.yml
