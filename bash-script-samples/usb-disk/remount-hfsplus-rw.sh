#sudo apt-get install hfsprogs
echo "Remounting $1 to $2"
mount -t hfsplus -o remount,force,rw,user,umask=0000  $1 "$2"
sudo chmod a+w "$2"
