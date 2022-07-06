cd $WORKING_DIR
service nginx start

rm -rf /opt/services/log/*
yarn
yarn dev > /opt/services/log/default.log
tail -f > /dev/null