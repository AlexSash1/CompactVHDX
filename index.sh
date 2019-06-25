#!/usr/bin/env bash

#check free size on partitian "sd" there means that we have only one=)
bkb=`df|  awk '{print $4,$6}' | grep -v '/\w' | grep '/' |awk '{print $1}'`
#set size of file for writing in Kb 
#check file size
let "sizenullfilekb = $bkb - 10000000"

echo sizenullfilekb is $sizenullfilekb

#this size in Gb
let "sizenullfileGb = $sizenullfilekb / 1048576"


echo sizenullfileGb is $sizenullfileGb



#cut all after dot and dot too
sizenullfileGb_cuted=`echo $sizenullfileGb | cut -f 1 -d .`

#log this size
echo "$sizenullfileGb size of writing file in Gygabyte"

#write file from zeroes
dd if=/dev/zero of=/tmp/null.file bs=1G count=$sizenullfileGb_cuted

#delete file
rm -f /tmp/null.file

