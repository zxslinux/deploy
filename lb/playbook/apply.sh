#!/bin/bash
#
cd $(dirname $0)

case $1 in
    install)
        ACTION=install;;
    uninstall)
        ACTION=uninstall;;
    upgrade)
        ACTION=upgrade;;
    rollback)
        ACTION=rollback;;
    *)
        echo "Usage: $0 {install|uninstall|upgrade|rollback}"
esac

ansible-playbook -i hosts site.yml --tags=$ACTION