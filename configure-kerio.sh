(
#server
sleep 1
echo $1

#autodetect
sleep 1
echo "yes"

#fingerprint ..
sleep 1
echo "yes"

#username
sleep 1
echo $2

#password
sleep 1
echo $3

sleep 1
) | dpkg-reconfigure kerio-control-vpnclient
