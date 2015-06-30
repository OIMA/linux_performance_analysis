#!/bin/bash
usage(){
    echo "Usage: $0 directory start|halt|status|restart|suspend|resume|reset"
}
if [[ $# -lt 2 ]]
    then
    echo "Error, bad number of arguments"
    usage
    exit 1
fi
if [[ ! -d $1 ]]
then
    echo "The first argument must be a directory"
    usage
fi 
start(){
    echo "Start signal sent"
}

halt(){
    echo "halt signal sent"
}

status(){
    vagrant_status="$(vagrant status | grep default | cut -c 27- | cut -d'(' -f1  | xargs)"
if [ "$vagrant_status" = "running" ] 
    then 
        echo "Your virtual machine is running"
    elif [ "$vagrant_status" = "poweroff" ]
        then
            echo "Your virtual machine is halted, running vagrant up"
    elif [ "$vagrant_status" = "saved" ]
        then
            echo "Your virtual machine is suspended, resuming session..."
    else
        echo "There is not a virtual environment on this directory"
fi
}

cd $1
$2 &>/dev/null
if [[ ! $? = 0 ]]
then
    echo "Error, bad argument provided"
    usage
fi
