#!/usr/bin/env bash
#dd if=/dev/zero of=/tmp/null.file ; rm -f /tmp/null.file



# dd if=/dev/fd0 of=floppy.img bs=1474560
#df| grep sd | awk ' {print $4} '
bkb=`df| grep sd | awk '{print $4}'`
sizenullfilekb=`echo $bkb-10000000 | /usr/bin/bc -l`

sizenullfileMb=`echo "$sizenullfilekb/1024" | /usr/bin/bc -l`

#echo $sizenullfileMb

sizenullfileMb_cuted=`echo $sizenullfileMb | cut -f 1 -d .`

echo $sizenullfileMb_cuted

#dd if=/dev/zero of=/tmp/null.file bs=1024K seek=$sizenullfileMb_cuted
dd if=/dev/zero of=/tmp/null.file bs=1 count=0 seek=`echo $sizenullfileMb_cuted`M
rm -f /tmp/null.file

