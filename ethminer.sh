#!/bin/bash
#/usr/local/bin/ethminer.sh

# where is it installed?

source /etc/ethrunner/ethrunner.vars

function d_start ( )
{
    echo  "ethminer: starting service"
    echo "RUN" > $ETHRUNNER_STATUS
    
    tmux \
	new-session -s ethminer -d \
	"$ETHRUNNER_PATH/while_eth.sh"
    sleep  5
    PID=$(ps -C ethminer -o pid | tail -n 1)
    echo $PID > $ETHMINER_PID
    echo "ethminer is running in a tmux session, try 'tmux a -t ethminer'"
    echo "PID is $PID"
    
}

function d_stop ( )
{
	echo  "ethminer: stopping Service (PID = $(cat $ETHMINER_PID))" 
	rm $ETHRUNNER_STATUS
	kill $(cat $ETHMINER_PID)
	rm $ETHMINER_PID
	tmux kill-session -t ethminer
}
 
function d_status ( ) 
{
    if [ -f $ETHMINER_PID ] ; then
	tmux capture-pane -pt ethminer -S -0 
	echo  "PID indication file $(cat $ETHMINER_PID 2> /dev/null)"
    else
	echo  "ethminer isn't running"
    fi
}
 
# Some Things That run always 
touch /var/lock/ethminer
 
# Management instructions of the service 
case "$1" in
	start )
		d_start
		;; 
	stop )
		d_stop
		;; 
	reload )
		d_stop
		sleep  1
		d_start
		;; 
	status )
		d_status
		;; 
	* ) 
	echo  "Usage: $ 0 {start | stop | reload | status}" 
	exit  1 
	;; 
esac
 
exit  0
