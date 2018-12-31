# vmlinux-deflater

this case - guest VM linux that have many write and delete, as example - swap file

before full backup VM i run this script, that write big file(whole free filesystem) and then remove it

this may reduse full backup because all free space on VM contain zeroes  

in my case 401Gb backup file was "deflated" to 293Gb =) maybe you will obtain more
