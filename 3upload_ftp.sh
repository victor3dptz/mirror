#!/bin/bash

clear
echo "Files are already on the FTP:"
ftp -pin <<EOF
open IP PORT
user USER PASS
ascii
cd ftp
ls *.rar
close
bye
EOF

echo 
cd /home/victor3d/bin/mirror/updates/
echo "Files available to upload:"
PS3="Select file to upload to Disk? "
select file in `ls /home/victor3d/bin/mirror/updates/`
do
echo "Uploading "$file
#ftp -pin <<EOF
#open IP PORT
#user USER PASS
#cd ftp
#binary
#hash
#put $file
#close
#bye
#EOF
curl -T /home/victor3d/bin/mirror/updates/$file -u USER:PASS ftp://IP:PORT/ftp/$file
echo $file uploaded to FTP!!
break
done
