#!/bin/bash
#
source /etc/profile
function check_cluster_status() {
    retry=10
    interval=5
    for ((i=0; i<=${retry}; ++i));do
        online_number=$(mysql -s -e "select MEMBER_STATE from performance_schema.replication_group_members;"|grep ONLINE|wc -l)
        if [[ X"$online_number" == X"3" ]];then
            echo "Checking cluster health OK!"
            break
        else
            if [ $i -lt $retry ];then
                sleep ${interval}
                continue
            else
                echo "Ckecking cluster health fail!"
                exit 1
            fi
        fi
    done
}

password='Zxs@2018'
mysql -e "
SET SQL_LOG_BIN=0;
CREATE USER rpl_user@'%' IDENTIFIED BY '$password';
GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;
CHANGE MASTER TO MASTER_USER='rpl_user', MASTER_PASSWORD='$password' FOR CHANNEL 'group_replication_recovery';
"

case $1 in
    start)
        mysql -e "start group_replication;";;
    stop)
        mysql -e "stop group_replication;";;
    bootstrap_start)
        mysql -e "
        set global group_replication_bootstrap_group=1;
        start group_replication;
        set global group_replication_bootstrap_group=0;
        ";;
    status)
        check_cluster_status;;
    *)
        echo "Usage: $0 {start|stop|bootstrap_start|status}";;
esac