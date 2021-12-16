# SmartZram
an easy to use smart zram manager for linux kernel
instead of making a big zram (like 2GB), one can split this into smaller zrams (like 0.5GB for each).Now if u want to reduce the zram for 0.5GB , you do not have to swapoff the whole zram and re create another one!.Now you can simply turn off one of the zram (each 0.5GB remmember ?).
also multiple Zram will improve the performance.
right now script is not smart enough! but will be improved on later commits.
you can use the script like
```
SmartZram.sh [AMOUNT OF ZRAM IN BYTES]
```
SmartZram.sh 2000000000 for example (for 2GB smart zram)

Note that almost all the zram manager will only check zram0 for swap 
so they probably will report wrong values.
you can always see the actual result with :
```
cat /proc/swaps
```
