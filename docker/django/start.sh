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
python3 $WORKING_DIR/manage.py migrate
python3 $WORKING_DIR/manage.py collectstatic --no-input

rm -rf /opt/services/log/*

if [ $DJANGO_CELERY == "True" ]
then
  /etc/init.d/celeryd start
  /etc/init.d/celerybeat start
fi

echo "from django.contrib.auth.models import User; User.objects.create_superuser(username='admin', email='merryljh91@naver.com', password='admin123')" | python3 $WORKING_DIR/manage.py shell >& /dev/null

service nginx start
gunicorn --reload --workers=9 --worker-class gevent --timeout 30 --bind unix:/var/run/connection.sock config.wsgi:application >> /opt/services/log/default.log
tail -f > /dev/null