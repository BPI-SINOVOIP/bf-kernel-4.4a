#!/bin/bash
k=$(make kernelversion)
#4.4.140
kn=$(echo $k|awk -F. '{print $1"."$2"."($3+1)}')
#4.4.141
kf=$(echo $k|awk -F. '{print $1"."$2"."$3"-"($3+1)}')
#4.4.140-141

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/incr/patch-$kf.xz
unxz patch-$kf.xz
patch -p1 --dry-run < patch-$kf
ret=$?
if [[ $ret -eq 0 ]];
then
	patch -p1 < patch-$kf
#	git status | grep -v ../u-boot | grep -v patch
	git ls-files --others --exclude-standard | grep -v patch
else
	echo -e "please call patch manually\npatch -p1 < patch-$kf"
fi
