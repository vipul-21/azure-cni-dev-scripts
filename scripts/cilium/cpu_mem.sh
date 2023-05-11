#!/bin/bash
sleepSeconds=30
dir="$1"
mkdir -p $dir
pod_file="$dir/pod-results.csv"
node_file="$dir/node-results.csv"
operator_file="$dir/operator-results.csv"
echo "time,pod,cpu,mem" > $pod_file
echo "time,node,cpu,cpuPercent,mem,memPercent" > $node_file
echo "time,pod,cpu,mem" > $operator_file

while true; do
    currentTime=`date -u`
    echo "running k top pod"
    lines=`kubectl top pod -n kube-system -l k8s-app=cilium | grep cilium | awk '{$1=$1;print}' | tr ' ' ',' | tr -d 'm' | tr -d 'Mi'`
    for line in $lines; do
        echo "$currentTime,$line" >> $pod_file
    done
    echo ",,," >>  $pod_file

    currentTime=`date -u`
    echo "running k top pod"
    lines=`kubectl top pod -n kube-system | grep cilium-operator | awk '{$1=$1;print}' | tr ' ' ',' | tr -d 'm' | tr -d 'Mi'`
    for line in $lines; do
        echo "$currentTime,$line" >> $operator_file
    done
    echo ",,," >> $operator_file

    currentTime=`date -u`
    echo "running k top node"
    lines=`kubectl top node | grep -v NAME | awk '{$1=$1;print}' | tr ' ' ',' | tr -d 'm' | tr -d 'Mi' | tr -d '%'`
    for line in $lines; do
        echo "$currentTime,$line" >> $node_file
    done
    echo ",,,,,," >> $node_file
    echo "sleeping $sleepSeconds seconds"
    sleep $sleepSeconds
done