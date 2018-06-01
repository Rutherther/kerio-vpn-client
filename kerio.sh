#!/usr/bin/env bash
set -o nounset

auth="/tmp/auth"
currentUser=""
currentPassword=""
currentDomain=""

waitForKvnet() {
    while ! ip a show kvnet up | grep inet  2>/dev/null; do
        sleep 1
    done
}

mount() { local ip=$1
    mkdir "/mnt/${ip}"

    createAuthFile $ip $currentUser $currentPassword $currentDomain
    sh /usr/bin/mounts.sh $auth $ip "/mnt/${ip}"
}

createAuthFile() {
    printf "server=${1}\nusername=${2}\npassword=${3}\ndomain=${4}\n" > $auth
}

authenticate() { local server=$1 user=$2 pass=$3 domain=$4
    currentUser=$user
    currentPassword=$pass
    currentDomain=$domain

    sh /usr/bin/configure-kerio.sh $server $user $pass

    /etc/init.d/kerio-kvc start
    waitForKvnet
}

unmount() {
    echo "hm"

    umount -f -a -t cifs
    rm -rf /mnt/*
    /etc/init.d/kerio-kvc stop

    trap - SIGINT SIGTERM
    exit 0
}


#1 - command (start/stop)

command=$1

case $command in
  "start")
     authenticate $2 $3 $4 $5
     for i in "${@:6}"; do
      mount $i
     done
     ;;
  "stop") unmount ;;
esac

trap unmount SIGINT SIGTERM

sleep infinity & wait
