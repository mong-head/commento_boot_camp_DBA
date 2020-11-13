--bin log 24시간동안 보관
call mysql.rds_set_configuration('binlog retention hours', 24);
call mysql.rds_show_configuration;

--bin log list
show binary logs;
--현재 바이너리 로그파일
SHOW MASTER STATUS ;


mysqlbinlog ^
    --read-from-remote-server ^
    --host=comento..ap-northeast-2.rds.amazonaws.com ^
    --port=3306  ^
    --user admin ^
    --password ^
    --base64-output=decode-rows -v ^
    mysql-bin-changelog.004398 > aa.sql
