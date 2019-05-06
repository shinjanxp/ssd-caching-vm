#!/bin/sh
sudo umount /home/shinjan/cached_disk/
sudo vgchange -a n
sudo make drivers/md/dm-cache-smq.ko -j 4
sudo rmmod dm-cache-smq && sudo insmod drivers/md/dm-cache-smq.ko 
sudo vgchange -a y
sudo mount /dev/CS695/lv_origin /home/shinjan/cached_disk/