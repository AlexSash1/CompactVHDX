#!/usr/bin/env bash
#dd if=/dev/zero of=/tmp/null.file ; rm -f /tmp/null.file



# dd if=/dev/fd0 of=floppy.img bs=1474560
#df| grep sd | awk ' {print $4} '
bkb=`df| grep sd | awk '{print $4}'`
sizenullfilekb=`echo $bkb-10000000 | /usr/bin/bc -l`

sizenullfileb=`echo $sizenullfilekb | /usr/bin/bc -l`

echo $sizenullfileb

dd if=/dev/zero of=/tmp/null.file bs=1024K seek=$sizenullfileb
rm -f /tmp/null.file

