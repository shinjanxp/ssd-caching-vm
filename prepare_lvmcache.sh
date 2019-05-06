#!/bin/sh
sudo umount /home/shinjan/cached_disk/
sudo vgchange -a n
sudo vgremove -y CS695
sudo vgcreate -y CS695 /dev/sdc1 /dev/sdb1
sudo lvcreate -y -L 1G -n lv_origin CS695 /dev/sdb1
sudo lvcreate -y -L 10M -n lv_cache CS695 /dev/sdc1
sudo lvcreate -y -L 5M -n lv_cache_meta CS695 /dev/sdc1
sudo lvconvert -y --type cache-pool --cachemode writethrough --poolmetadata CS695/lv_cache_meta CS695/lv_cache
sudo lvconvert -y --type cache /dev/CS695/lv_origin --cachepool /dev/CS695/lv_cache
sudo lvs -a -o +devices
sudo mkfs -t ext4 /dev/CS695/lv_origin