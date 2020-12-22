#!/bin/bash


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
TRACKS_HOME=$(readlink -f $(dirname $0)/..)
LOG_FILE=${TRACKS_HOME}/log/tracks-mail.log

exec 1>>$LOG_FILE
exec 2>&1 

source /usr/local/rvm/scripts/rvm
rvm use 2.5.0

task_id=`uuidgen`

echo "[${task_id}] Started at `date +%Y%m%d-%H%M%S`"

cd $TRACKS_HOME
bin/rails r -e mail "MessageGateway.receive(STDIN.read)" 
RC=$?

echo "[${task_id}] Finished at `date +%Y%m%d-%H%M%S`"

exit $RC

