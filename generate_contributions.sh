#!/bin/sh

roles="aide alternatives anaconda ansible ansible_lint apt_autostart ara artifactory at atom auditd auto_update awx azure_cli backup bios_update bootstrap buildtools ca ca_certificates cargo clamav cntlm collectd common container_docs core_dependencies cron debug dhcpd digitalocean-agent dns docker docker_ce dovecot dsvpn earlyoom eclipse environment epel etherpad facts fail2ban firewall forensics git gitlab_runner glusterfs go gotop haproxy haveged hostname httpd investigate irslackd java jenkins kernel kubectl locale logrotate logwatch lynis maintenance mediawiki memcached microsoft_repository_keys minikube mitogen molecule mssql mysql natrouter nginx npm ntp obsproject omsagent openssh openvpn owncloud packer php php_fpm phpmyadmin postfix postgres powertools powertop python_pip reboot redis release remi restore revealmd roundcubemail rpmfusion rsyslog ruby rundeck scl selinux service snort sosreport spamassassin squid storage stratis subversion sudo-pair swap sysctl sysstat terraform test_connection tftpd tomcat travis ulimit unbound unowned_files update update_package_cache users vagrant virtualbox xinetd y zabbix_agent zabbix_proxy zabbix_repository zabbix_server zabbix_web"

echo "|Role|Issues|Pull requests|"

for role in ${roles} ; do
  echo "|[${role}](https://galaxy.ansible.com/robertdebock/${role})|[![issues](https://img.shields.io/github/issues-raw/robertdebock/ansible-role-${role})](https://github.com/robertdebock/ansible-role-${role}/issues)|[![pull requests](https://img.shields.io/github/issues-pr/robertdebock/ansible-role-${role})](https://github.com/robertdebock/ansible-role-${role}/pulls)|"
done
