GRANT SELECT ON `sys`.`gr_member_routing_candidate_status` TO 'haproxy'@'%' IDENTIFIED BY 'Haproxy@2020';
ALTER USER root@'localhost' IDENTIFIED BY '{{mysql.password}}';