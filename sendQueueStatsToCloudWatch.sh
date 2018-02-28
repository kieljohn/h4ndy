#!/bin/bash
# Simple script which reads the localhost beanstalkd queue and sends basic details
# off to cloudwatch, so you can set alarms, etc.
#
NAMESPACE="your-cloudwatch-namespace-here"
echo -e "stats\r\n" | nc localhost 11300 | sed "s/://g" | grep ^current- | awk '{system("aws cloudwatch put-metric-data --metric-name "$1" --namespace $NAMESPACE --value "$2" --timestamp $( date \"+%Y-%m-%dT%H:%M:%S.000Z\" )")}'
