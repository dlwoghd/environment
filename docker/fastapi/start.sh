pip install -r $WORKING_DIR/requirements.txt

chk_ping ()
{
  # Set count with argument 1 or default 5
  count=${DB_CHECK_COUNT}
  # Perform count checks
  while [ $count -gt 0 ]
  do
    sleep ${DB_CHECK_INTERVER}
    count=$((count-1))
    # If it got a pong, it can return success
    DBEXISTS=$(mysql --batch --skip-column-names -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" -p${MYSQL_ROOT_PASSWORD} -uroot -h $DATABASE_IP | grep "$DBNAME" > /dev/null; echo "$?")
    if [ $DBEXISTS -eq 0 ];then
        echo "Database Connect."
        break
    else
        echo "Database Waiting."
    fi
  done
  # It reaches here if all ping checks failed, so return failure
  return 1 # failure
}

chk_ping

rm -rf /opt/services/log/*
touch /opt/services/log/default.log
service nginx start
uvicorn main:app --reload --uds /var/run/connection.sock > /opt/services/log/default.log
tail -f > /dev/null