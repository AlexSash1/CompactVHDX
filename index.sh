#!/usr/bin/env bash

#check free size on partitian "sd" there means that we have only one=)
bkb=`df| grep sd | awk '{print $4}'`

#set size of file for writing in Kb 
sizenullfilekb=`echo $bkb-10000000 | /usr/bin/bc -l`

#this size in Gb
sizenullfileGb=`echo "$sizenullfilekb/1048576" | /usr/bin/bc -l`

#cut all after dot and dot too
sizenullfileGb_cuted=`echo $sizenullfileGb | cut -f 1 -d .`

#log this size
echo "$sizenullfileGb size of writing file in Gygabyte"

#write file from zeroes
dd if=/dev/zero of=/tmp/null.file bs=1G count=$sizenullfileGb_cuted

#delete file
rm -f /tmp/null.file

