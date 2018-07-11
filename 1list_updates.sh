#!/bin/bash
clear
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
echo "Updates available:"
lynx -dump http://URL/popoln/ > $list

cat $list|grep http://URL/popoln/1 > $tmp

while iFS='' read -r line || [[ -n "$line" ]]; do
pos=`strpos "${line}" "/popoln/"`
substr "${line}" $pos+8
done < "$tmp"

#cat $tmp
echo 
cd /home/victor3d/bin/mirror/updates/
echo "Already downloaded:"
ls -1

rm -f $list
rm -f $tmp
