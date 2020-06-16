#!/bin/bash -xe
id=$1
first=$(echo $id | cut -c1)
m=/var/spool/postfix/deferred/$first/$id
if [[ -z $m || ! -f $m ]] ; then
  echo "Usage: $0 MAILQUEUEID"
  exit 5
fi

# backup old msg file
bakdir=/root/postfixqueuebak
mkdir -p $bakdir
cp -a $m $bakdir
stat $m > $bakdir/$id.stat

# create new queue msg
new=$bakdir/$id.new
/usr/local/sbin/rewritepostqueue $m > $new
# verify new file is not empty
test -s $new

filter=/usr/local/sbin/postqueue-raw-dump
! diff <($filter "$m") <($filter "$new")

# move new mail into the old place
# using cat here to keep old inode number, because that correlates
# with filename. The alternative would be to use postsuper -s as fixup
cat $new > $m
postqueue -i $id
