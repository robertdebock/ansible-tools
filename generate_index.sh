#!/bin/sh

counter=1 ; for role in alternatives anaconda ansible ansible_lint apt_autostart ara artifactory at atom auditd awx backup bios_update bootstrap buildtools ca cargo clamav cloud9 cntlm common container_docs cron dhcpd digitalocean-agent dns docker docker_ce dovecot dsvpn earlyoom environment epel etherpad fail2ban firewall git gitlab_runner glusterfs go gotop haproxy haveged hostname httpd investigate irslackd java jenkins kernel kubectl locale logrotate logwatch lynis mediawiki memcached minikube mitogen molecule mssql mysql natrouter nginx npm ntp obsproject openssh openvas openvpn owncloud packer php php_fpm phpmyadmin postfix postgres powertop python_pip reboot redis release remi restore revealmd roundcubemail rpmfusion rsyslog ruby rundeck scl selinux service snort sosreport spamassassin squid storage stratis subversion sudo-pair sysctl sysstat terraform tftpd tomcat travis ulimit update update_package_cache users vagrant xinetd y zabbix zabbix_agent zabbix_proxy zabbix_repository zabbix_server zabbix_web ; do echo "<tr><td>${counter}</td><td><a href=\"https://galaxy.ansible.com/robertdebock/${role}\">${role}</a></td><td><a href=\"https://travis-ci.org/robertdebock/ansible-role-${role}\"><img src=\"https://api.travis-ci.org/robertdebock/ansible-role-${role}.svg?branch=master\"/></a></td><td><a href=\"https://github.com/robertdebock/ansible-role-${role}/releases\"><img src=\"https://img.shields.io/github/commits-since/robertdebock/ansible-role-${role}/latest.svg\"/></a></td><td><a href=\"https://github.com/robertdebock/ansible-role-${role}/issues\"><img src=\"https://img.shields.io/github/issues-raw/robertdebock/ansible-role-${role}\"></a></td><td><a href=\"https://github.com/robertdebock/ansible-role-${role}/pulls\"><img src=\"https://img.shields.io/github/issues-pr/robertdebock/ansible-role-${role}\"></a></td></tr>" ; ((counter++)) ; done