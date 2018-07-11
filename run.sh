#!/bin/bash
clear
cd /home/victor3d/bin/mirror/updates/
echo "Already downloaded:"
ls -1
cd ..
echo

substr()
{
    local length=${3}
    if [ -z "${length}" ]; then
        length=$((${#1} - ${2}))
    fi
    local str=${1:${2}:${length}}
    if [ "${#str}" -eq "${#1}" ]; then
        echo "${1}"
    else
        echo "${str}"
    fi
}
strpos()
{
    local str=${1}
    local offset=${3}
    if [ -n "${offset}" ]; then
        str=`substr "${str}" ${offset}`
    else
        offset=0
    fi
    str=${str/${2}*/}
    if [ "${#str}" -eq "${#1}" ]; then
        return 0
    fi
    echo $((${#str}+${offset}))
}

list=`mktemp`
tmp=`mktemp`
files=`mktemp`
echo "Updates available:"
lynx -dump http://URL/popoln/ > $list

cat $list|grep http://URL/popoln/1 > $tmp

while iFS='' read -r line || [[ -n "$line" ]]; do
pos=`strpos "${line}" "/popoln/"`
substr "${line}" $pos+8 >> $files
done < "$tmp"

PS3="Select file to download from URL? "
select file in `cat $files`
do
get=`substr "${file}" 0 8`
bash ./2download.sh $get
break
done

bash ./3upload_ftp.sh
rm -f $list
rm -f $tmp
rm -f $files
