#!/bin/bash

if [ ! -z "$1" ]
then
m=$1".rar"
else
m=`date +"%y_%m_%d"`".rar"
fi
ls -1 /home/victor3d/bin/mirror/updates>/home/victor3d/bin/mirror/dir1
# Качаем только сегодняшнее обновление ГГ_ММ_ДД.rar для экономии места на диске
# Если в этот день не скачалось (ошибка, инета нет) то на след. день не найдет
wget --show-progress --progress=dot -nd -A $m --mirror -np --directory-prefix /home/victor3d/bin/mirror/updates http://URL/popoln/
#wget -nv -nd -A.rar --mirror -o /root/mirror/wget.log -np --directory-prefix /var/www/private/update ftp://URL/public/popoln/
ls -1 /home/victor3d/bin/mirror/updates>/home/victor3d/bin/mirror/dir2

if diff /home/victor3d/bin/mirror/dir1 /home/victor3d/bin/mirror/dir2 > /dev/null ; then
echo No new files
else
echo Got new files
 # Провека по маске года например 15_
 if tail --lines 1 /home/victor3d/bin/mirror/dir2 |grep `date +"%y"`_ > /dev/null ; then
# echo >> /root/mirror/wget.log
# echo "New update: /srv/consupdate/`tail --lines 1 /root/mirror/dir2`" >> /root/mirror/wget.log
# echo >> /root/mirror/wget.log
# echo "Free space available on victor3d.com.br: `df|grep /dev/vda2`" >> /root/mirror/wget.log
# echo "Server uptime: `uptime`" >> /root/mirror/wget.log
# echo >> /root/mirror/wget.log
 cd /home/victor3d/bin/mirror/updates/
 ftp -inv <<EOF >> /home/victor3d/bin/mirror/wget.log 2>&1
 open IP PORT
 user USER PASS
 binary
 cd ftp
 put /home/victor3d/bin/mirror/updates/`tail --lines 1 /home/victor3d/bin/mirror/dir2` `tail --lines 1 /home/victor3d/bin/mirror/dir2`
 size `tail --lines 1 /home/victor3d/bin/mirror//dir2`
 close
 bye
EOF

# echo >> /root/mirror/wget.log
# echo "File `tail --lines 1 /root/mirror/dir2` uploaded to Disk!" >> /root/mirror/wget.log
# echo >> /root/mirror/wget.log

 ftp -in <<EOF >> /home/victor3d/bin/mirror/wget.log 2>&1
 open IP PORT
 user USER PASS
 ascii
 cd ftp
 ls
 close
 bye
EOF
else
# echo >> /root/mirror/wget.log
# echo "Something got wrong! List of files downloaded:" >> /root/mirror/wget.log
# echo `ls -1 /srv/consupdate/` >> /root/mirror/wget.log
echo "Error"
fi

# echo `cat /root/mirror/wget.log`
echo "Update succesful!"
fi
