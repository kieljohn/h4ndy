#!/bin/bash
# Simple script which checks EC2 tags on this instance and returns 0 if the tag
# was found, and 1 if it doesn't this can be chained with other commands such as
#
# ./checkTag.sh RunCrons Yes && echo "On"
#
# This will only return "On" if the TAG "RunCrons" is set to Yes and attached to
# this instance in EC2 management
#
# Depends On: http://s3.amazonaws.com/ec2metadata/ec2-metadata
#
my_dir="$(dirname "$0")"
cmdexec=`aws ec2 describe-tags --filter="resource-type=instance" --filter "Name=resource-id,Values=$($my_dir/ec2-metadata -i | cut -d ' ' -f2)" --filters Name=tag:$1,Values=$2 --output text | grep $1 | grep $2`
exit $?
