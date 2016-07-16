#sudo apt-get install hfsprogs
echo "Mounting $1 to $2"
mount -t hfsplus -o force,rw,user,umask=0000  $1 "$2"
