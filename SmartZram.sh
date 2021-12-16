ZRAM_NEEDED=$1
EMTYSTR=""
tmp=0
echo "${ZRAM_NEEDED} bytes of zram is needed"
ls /sys/block | grep zram | while read -r line ; do
    echo "Processing $line"
    swapoff /dev/block/$line
    echo 1 > /sys/block/$line/reset
    zramnumber=$(echo "$line" | sed "s/zram/$EMTYSTR/")
    echo "zramnumber is $zramnumber"
    echo $zramnumber > /sys/class/zram-control/hot_remove
done
while [ $ZRAM_NEEDED -ge 1 ]
do
if [ $ZRAM_NEEDED -ge $((1024*1024*1024))]; then
tmp=$((1024*1024*1024))
else
tmp=$ZRAM_NEEDED
fi
ZRAM_NEEDED=$(($ZRAM_NEEDED-$tmp))
azramnumber=$(cat /sys/class/zram-control/hot_add)
echo 1 > /sys/block/zram$azramnumber/reset
echo $tmp > /sys/block/zram$azramnumber/disksize
mkswap /dev/block/zram$azramnumber
swapon /dev/block/zram$azramnumber
done
