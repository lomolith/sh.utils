#!/bin/sh
export JOB_MAX=6
export JOB_NAME="java AllProcessTCGA"
export DIR_WORK="/home/ubuntu/workspace/tcga/data_pre"

cd $DIR_WORK
for FNAME in `ls $vcf.txt`
do
        loop=0
        while [ $loop -eq 0 ]
        do
                JOBS="`ps -ef | grep "$JOB_NAME" | grep -v grep | wc -l `"
                if [ $JOBS -lt $JOB_MAX ]
                then
                        DATE="`date`"
                        echo "$DATE :: Add a job for $FNAME"
                        java AllProcessTCGA $DIR_WORK $FNAME > log.$DATE.$FNAME 2>&1 &
                else
                        echo "Currently $JOBS jobs are running.. Waiting for another minute.."
                        sleep 1m
                fi
        done
done
