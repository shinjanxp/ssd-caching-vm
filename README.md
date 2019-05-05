# Introduction
README for CS695

# Make logical volumes 
* sudo su
* vgcreate CS695 /dev/sdc1 /dev/sdb1
* lvcreate -l 100%FREE -n lv_origin CS695 /dev/sdb1
* lvcreate -L 200G -n lv_cache CS695 /dev/sdc1
* lvcreate -L 5G -n lv_cache_meta CS695 /dev/sdc1
* lvconvert --type cache-pool --cachemode writethrough --poolmetadata CS695/lv_cache_meta CS695/lv_cache
* lvconvert --type cache /dev/CS695/lv_origin --cachepool /dev/CS695/lv_cache
* lvs -a -o +devices
* mkfs -t ext4 /dev/CS695/lv_origin 


# Destroy logical volumes
* sudo vgremove CS695


# Make and install
* sudo make drivers/md/dm-cache-smq.ko -j 4
* sudo rmmod dm-cache-smq && sudo insmod drivers/md/dm-cache-smq.ko 

# Enable and mount
* sudo vgchange -a y
* sudo mount /dev/CS695/lv_origin /home/shinjan/cached_disk/

# Disable and unmount
* sudo umount /home/shinjan/cached_disk/
* sudo vgchange -a n

