MOUNT=$3
AUTHFILE=$1
SERVER=$2

echo "smbclient -A ${AUTHFILE} -L ${SERVER}"

SHARES=`smbclient --debuglevel=0 -A $AUTHFILE -L $SERVER -g 2>/dev/null | grep "Disk" | sed 's/|/ /g' | awk '{print $2}'`

mkdir -p $MOUNT

for NAMES in $SHARES; do
  FULLPATH="//${SERVER}/${NAMES}"

  MOUNTPOINT=$MOUNT/$NAMES
  mkdir -p $MOUNTPOINT

  mount -t cifs -o credentials=$AUTHFILE,iocharset=utf8,file_mode=0777,dir_mode=0777 $FULLPATH $MOUNTPOINT

done

exit 0
